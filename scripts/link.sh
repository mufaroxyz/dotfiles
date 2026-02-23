#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if command -v stow >/dev/null 2>&1; then
    exec "$repo_root/scripts/stow-link.sh"
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

link_path() {
    local source="$1"
    local target="$2"

    if [ ! -e "$source" ] && [ ! -L "$source" ]; then
        printf 'missing source: %s\n' "$source"
        return 1
    fi

    mkdir -p "$(dirname "$target")"

    if [ -L "$target" ]; then
        if [ "$(realpath -m "$target")" = "$(realpath -m "$source")" ]; then
            printf 'already linked: %s\n' "$target"
            return 0
        fi
        backup_path "$target"
    elif [ -e "$target" ]; then
        backup_path "$target"
    fi

    ln -s "$source" "$target"
    printf 'linked %s -> %s\n' "$target" "$source"
}

link_path "$repo_root/hypr" "$HOME/.config/hypr"
link_path "$repo_root/quickshell" "$HOME/.config/quickshell/akane"
link_path "$repo_root/xdg-desktop-portal/hyprland-portals.conf" "$HOME/.config/xdg-desktop-portal/hyprland-portals.conf"

printf 'done\n'
