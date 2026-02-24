from pathlib import Path

PROJECT_ROOT: Path = Path(__file__).resolve().parents[2]
CACHE_DIR: Path = PROJECT_ROOT / "assets" / "cache"
TEMPLATE_PATH: Path = PROJECT_ROOT / "assets" / "colors.qml.template"
WALLPAPER_SYMLINK: Path = PROJECT_ROOT / "assets" / "current_wallpaper"
WALLPAPER_STAMP: Path = PROJECT_ROOT / "assets" / "current_wallpaper.stamp"
COLORS_SYMLINK: Path = PROJECT_ROOT / "core" / "Colors.qml"
