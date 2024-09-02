{ config, lib, pkgs, inputs, ... }:
let username = "mufaro";
in
{
  users.users.${username} = {
    isNormalUser = true;
    description = "Mufaro";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
  };

  imports = [ (import ./home { inherit pkgs username inputs; }) ./programs.nix ];
}
