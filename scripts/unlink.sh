#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if command -v stow >/dev/null 2>&1; then
    exec "$repo_root/scripts/stow-unlink.sh"
fi

unlink_path() {
    local source="$1"
    local target="$2"
    local backup="${target}.bak"

    if [ -L "$target" ] && [ "$(realpath -m "$target")" = "$(realpath -m "$source")" ]; then
        rm "$target"
        printf 'removed link: %s\n' "$target"
    fi

    if [ ! -e "$target" ] && [ ! -L "$target" ] && { [ -e "$backup" ] || [ -L "$backup" ]; }; then
        mv "$backup" "$target"
        printf 'restored backup: %s\n' "$target"
    fi
}

unlink_path "$repo_root/hypr" "$HOME/.config/hypr"
unlink_path "$repo_root/quickshell" "$HOME/.config/quickshell/akane"
unlink_path "$repo_root/xdg-desktop-portal/hyprland-portals.conf" "$HOME/.config/xdg-desktop-portal/hyprland-portals.conf"

printf 'done\n'
