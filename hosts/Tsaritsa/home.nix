{
  imports = [
    ../../modules/home/desktop-apps.nix
    ../../modules/home/coding-agents.nix
  ];

  home = {
    username = "mufaro";
    homeDirectory = "/home/mufaro";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
