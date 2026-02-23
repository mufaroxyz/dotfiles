#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
stow_dir="$repo_root/stow"

if ! command -v stow >/dev/null 2>&1; then
    printf 'stow is not installed\n'
    exit 1
fi

backup_path() {
    local target="$1"
    local backup="${target}.bak"
    local i=1

    while [ -e "$backup" ] || [ -L "$backup" ]; do
        backup="${target}.bak.${i}"
        i=$((i + 1))
    done

    mv "$target" "$backup"
    printf 'backed up %s -> %s\n' "$target" "$backup"
}

backup_if_needed() {
    local target="$1"
    local source="$2"

    if [ ! -e "$target" ] && [ ! -L "$target" ]; then
        return 0
    fi

    if [ -L "$target" ] && [ "$(realpath -m "$target")" = "$(realpath -m "$source")" ]; then
        printf 'already managed: %s\n' "$target"
        return 0
    fi

    backup_path "$target"
}

mkdir -p "$HOME/.config/quickshell" "$HOME/.config/xdg-desktop-portal"

backup_if_needed "$HOME/.config/hypr" "$stow_dir/hypr/.config/hypr"
backup_if_needed "$HOME/.config/quickshell/akane" "$stow_dir/quickshell/.config/quickshell/akane"
backup_if_needed "$HOME/.config/xdg-desktop-portal/hyprland-portals.conf" "$stow_dir/xdg-desktop-portal/.config/xdg-desktop-portal/hyprland-portals.conf"

stow --dir "$stow_dir" --target "$HOME" --restow hypr quickshell xdg-desktop-portal

printf 'done\n'
