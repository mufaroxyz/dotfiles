import hashlib
from pathlib import Path


def get_file_hash(file_path: Path) -> str:
    digest = hashlib.sha256()
    with file_path.open("rb") as source:
        while chunk := source.read(1024 * 1024):
            digest.update(chunk)
    return digest.hexdigest()


def force_symlink(target: Path, link_name: Path) -> None:
    if link_name.is_symlink() or link_name.exists():
        link_name.unlink()
    link_name.parent.mkdir(parents=True, exist_ok=True)
    link_name.symlink_to(target)
