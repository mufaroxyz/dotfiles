{pkgs, ...}: {
  programs.git = {
    enable = true;

    userName = "mufaroxyz";
    userEmail = "mufaro.priv@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  home.packages = [pkgs.gh];
}
