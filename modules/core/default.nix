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
  nixos = nixpkgs.lib.nixOsSystem
    {
      specialArgs = { inherit self inputs username; };
      modules =
        [ (import ./bootloader.nix) ]
        ++ [ (import ./hardware.nix) ]
        ++ [ (import ./xserver.nix) ]
        ++ [ (import ./locales.nix) ]
        ++ [ (import ./networking.nix) ]
        ++ [ (import ./services.nix) ]
        ++ [ (import ./user.nix) ]
        ++ [ (import ./wayland.nix) ]
        ++ [ (import ./system.nix) ]
        ++ [ (import ./pipewire.nix) ]
        ++ [ (import ./../../hosts/mufaro/hardware-configuration.nix) ];
    };
}
