{ pkgs, ... }:
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

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      wakatime.vscode-wakatime
      github.copilot
      ziglang.vscode-zig
      jnoortheen.nix-ide
      yoavbls.pretty-ts-errors
      # no gruber theme :(
    ];
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.home-manager.enable = true;
}
