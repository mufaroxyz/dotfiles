{ inputs
, nixpkgs
, self
, username
, ...
}:
let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
in
{
  nixos = nixpkgs.lib.nixosSystem
    {
      specialArgs = { inherit self inputs username; };
      modules =
        [
          ./boot.nix
          ./hardware.nix
          ./xserver.nix
          ./steam.nix
          ./sleepy-launcher.nix
          ./networking.nix
          ./pipewire.nix
          ./programs.nix
          ./security.nix
          ./services.nix
          ./user.nix
          ./wayland.nix
          ./system.nix
          ./nvidia.nix
          ./activation.nix
          ../../hosts/nixos/hardware-configuration.nix
        ];
    };
}
