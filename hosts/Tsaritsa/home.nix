{
  imports = [
    ../../modules/home/desktop-apps.nix
    ../../modules/home/opencode.nix
  ];

  home = {
    username = "mufaro";
    homeDirectory = "/home/mufaro";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
