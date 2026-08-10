{
  nix.enable = false;
  nixpkgs.hostPlatform = "aarch64-darwin";
  networking.computerName = "Odette";
  networking.hostName = "Odette";
  system.primaryUser = "mufaro";
  system.stateVersion = 7;
  users.users.mufaro.home = "/Users/mufaro";
}
