{ pkgs, ... }:
{
  # ponytail: Signal stays vendor-managed until nixpkgs supports database schema 1760.
  home.packages = with pkgs; [
    prismlauncher
    zed-editor
  ];
}
