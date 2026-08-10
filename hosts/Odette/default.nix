{
  nix.enable = false;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  networking.computerName = "Odette";
  networking.hostName = "Odette";
  system.primaryUser = "mufaro";
  system.stateVersion = 7;
  users.users.mufaro.home = "/Users/mufaro";
}
