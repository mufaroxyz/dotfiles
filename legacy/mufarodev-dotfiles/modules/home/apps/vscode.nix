{ pkgs, ... }: {
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
}
