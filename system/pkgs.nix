{ pkgs, inputs, ... }:
let
  packages = with pkgs; [
    vim
    git
    rofi
    wofi
    neovim
    zed-editor
    gamemode
    libnotify
    dunst
    wl-clipboard
    egl-wayland
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    inputs.zen-browser.packages.${pkgs.system}.default
    inputs.ghostty.packages.${pkgs.system}.default
    rose-pine-cursor
    qt6.qtwayland
    wrangler
    mako
  ];
in
packages
