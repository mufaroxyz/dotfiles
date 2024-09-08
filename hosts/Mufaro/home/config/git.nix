{
  programs.git = {
    enable = true;
    userName = "mufaroxyz";
    userEmail = "81554673+mufaroxyz@users.noreply.github.com";
    extraConfig = {
      gpg.format = "ssh";
      user.signingKey = "~/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
      url."ssh://git@".pushInsteadOf = "https://";
    };
  };
}
