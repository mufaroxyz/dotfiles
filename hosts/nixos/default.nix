{ lib, ... }:
let
  legacy = ../../legacy/mufarodev-dotfiles;
in
{
  # ponytail: compatibility only; replace this whole file during the rewrite.
  imports = [
    (legacy + "/modules/core/boot.nix")
    (legacy + "/modules/core/hardware.nix")
    (legacy + "/modules/core/xserver.nix")
    (legacy + "/modules/core/steam.nix")
    (legacy + "/modules/core/sleepy-launcher.nix")
    (legacy + "/modules/core/networking.nix")
    (legacy + "/modules/core/pipewire.nix")
    (legacy + "/modules/core/programs.nix")
    (legacy + "/modules/core/security.nix")
    (legacy + "/modules/core/services.nix")
    (legacy + "/modules/core/user.nix")
    (legacy + "/modules/core/wayland.nix")
    (legacy + "/modules/core/system.nix")
    (legacy + "/modules/core/nvidia.nix")
    (legacy + "/modules/core/activation.nix")
    (legacy + "/modules/core/postgres.nix")
    (legacy + "/hosts/nixos/hardware-configuration.nix")
  ];

  programs.ssh.knownHostsFiles = lib.mkForce [ ];
}
