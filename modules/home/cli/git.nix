{ pkgs, ... }: {
  programs.git = {
    userName = "mufaroxyz";
    userEmail = "81554673+mufaroxyz@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
      gpg.format = "ssh";
      user.signingKey = "~/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
      url."ssh://git@".pushInsteadOf = "https://";
    };
  };

  home.packages = [ pkgs.gh ];
}
