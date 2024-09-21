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
        [ (import ./boot.nix) ]
        ++ [ (import ./hardware.nix) ]
        ++ [ (import ./xserver.nix) ]
        ++ [ (import ./steam.nix) ]
        ++ [ (import ./networking.nix) ]
        ++ [ (import ./pipewire.nix) ]
        ++ [ (import ./programs.nix) ]
        ++ [ (import ./security.nix) ]
        ++ [ (import ./services.nix) ]
        ++ [ (import ./user.nix) ]
        ++ [ (import ./wayland.nix) ]
        ++ [ (import ./system.nix) ]
        ++ [ (import ./../../hosts/mufaro/hardware-configuration.nix) ];
    };
}
