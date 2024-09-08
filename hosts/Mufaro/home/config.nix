{ pkgs, ... }:
{

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.home-manager.enable = true;
}
