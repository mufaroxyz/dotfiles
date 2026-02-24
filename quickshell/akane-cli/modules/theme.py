import os
import subprocess
import tempfile
from pathlib import Path

from core.config import (
    CACHE_DIR,
    COLORS_SYMLINK,
    TEMPLATE_PATH,
    WALLPAPER_STAMP,
    WALLPAPER_SYMLINK,
)
from core.utils import force_symlink, get_file_hash


def _toml_string(value: str) -> str:
    escaped = value.replace("\\", "\\\\").replace('"', '\\"')
    return f'"{escaped}"'


def apply_theme(image_path_str: str) -> None:
    image_path = Path(image_path_str).expanduser().resolve()
    if not image_path.is_file():
        raise FileNotFoundError(f"Image does not exist: {image_path}")
    if not TEMPLATE_PATH.is_file():
        raise FileNotFoundError(f"Template does not exist: {TEMPLATE_PATH}")

    image_hash = get_file_hash(image_path)
    cache_target = CACHE_DIR / f"{image_hash}_colors.qml"
    CACHE_DIR.mkdir(parents=True, exist_ok=True)

    if not cache_target.is_file():
        config_contents = "\n".join(
            [
                "[config]",
                "caching = false",
                'fallback_color = "#ffffff"',
                "",
                "[templates.akane_colors]",
                f"input_path = {_toml_string(str(TEMPLATE_PATH))}",
                f"output_path = {_toml_string(str(cache_target))}",
            ]
        )
        with tempfile.TemporaryDirectory(prefix="akane-cli-") as temp_dir:
            config_path = Path(temp_dir) / "matugen.toml"
            config_path.write_text(f"{config_contents}\n", encoding="utf-8")
            environment = os.environ.copy()
            environment["XDG_CONFIG_HOME"] = temp_dir

            try:
                subprocess.run(
                    [
                        "matugen",
                        "image",
                        str(image_path),
                        "--config",
                        str(config_path),
                        "--source-color-index",
                        "0",
                        "--quiet",
                    ],
                    check=True,
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.PIPE,
                    text=True,
                    env=environment,
                )
            except FileNotFoundError as error:
                raise RuntimeError(
                    "matugen executable was not found in PATH"
                ) from error
            except subprocess.CalledProcessError as error:
                cache_target.unlink(missing_ok=True)
                details = error.stderr.strip() if error.stderr else ""
                if details:
                    raise RuntimeError(f"matugen failed: {details}") from error
                raise RuntimeError("matugen failed to generate theme colors") from error

        if not cache_target.is_file():
            raise RuntimeError(f"matugen did not generate output: {cache_target}")

    force_symlink(image_path, WALLPAPER_SYMLINK)
    WALLPAPER_STAMP.write_text(f"{image_hash}\n", encoding="utf-8")
    force_symlink(cache_target, COLORS_SYMLINK)
