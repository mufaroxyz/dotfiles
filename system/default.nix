{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware
    ./nix
    ./boot.nix
    ./env.nix
    ./fonts.nix
    ./locales.nix
    ./networking.nix
    ./services.nix
  ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = import ./pkgs.nix { inherit pkgs inputs; };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  system.stateVersion = "24.05";
}
