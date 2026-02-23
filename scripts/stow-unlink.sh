#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
stow_dir="$repo_root/stow"

if ! command -v stow >/dev/null 2>&1; then
    printf 'stow is not installed\n'
    exit 1
fi

restore_backup() {
    local target="$1"
    local backup="${target}.bak"

    if [ ! -e "$target" ] && [ ! -L "$target" ] && { [ -e "$backup" ] || [ -L "$backup" ]; }; then
        mv "$backup" "$target"
        printf 'restored backup: %s\n' "$target"
    fi
}

stow --dir "$stow_dir" --target "$HOME" --delete hypr quickshell xdg-desktop-portal

restore_backup "$HOME/.config/hypr"
restore_backup "$HOME/.config/quickshell/akane"
restore_backup "$HOME/.config/xdg-desktop-portal/hyprland-portals.conf"

printf 'done\n'
