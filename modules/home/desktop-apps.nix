{ pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
    signal-desktop
    zed-editor
  ];
}
