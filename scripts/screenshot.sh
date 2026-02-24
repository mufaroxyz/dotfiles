#!/usr/bin/env bash
set -euo pipefail

mode="${1:-full}"

notify() {
    local message="$1"
    if command -v notify-send >/dev/null 2>&1; then
        notify-send "Screenshot" "$message"
    elif command -v hyprctl >/dev/null 2>&1; then
        hyprctl notify -1 2500 "rgb(88cc88)" "$message" >/dev/null 2>&1 || true
    fi
}

require_cmd() {
    local cmd="$1"
    if ! command -v "$cmd" >/dev/null 2>&1; then
        notify "Missing dependency: $cmd"
        exit 1
    fi
}

require_cmd grim

if [ "$mode" = "region" ]; then
    require_cmd slurp
fi

pictures_dir="${XDG_PICTURES_DIR:-}"
if [ -z "$pictures_dir" ] && command -v xdg-user-dir >/dev/null 2>&1; then
    pictures_dir="$(xdg-user-dir PICTURES 2>/dev/null || true)"
fi
if [ -z "$pictures_dir" ]; then
    pictures_dir="$HOME/Pictures"
fi

target_dir="$pictures_dir/Screenshots"
mkdir -p "$target_dir"

timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
target_file="$target_dir/screenshot_$timestamp.png"

if [ "$mode" = "region" ]; then
    area="$(slurp)"
    if [ -z "$area" ]; then
        notify "Screenshot cancelled"
        exit 0
    fi
    grim -g "$area" "$target_file"
else
    grim "$target_file"
fi

if command -v wl-copy >/dev/null 2>&1; then
    wl-copy < "$target_file"
    notify "Saved and copied: $target_file"
else
    notify "Saved: $target_file"
fi
