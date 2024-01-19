{pkgs, ...}: {
  imports = [(import ./catppuccin-mocha.nix)];
  home.packages = with pkgs; [
    (discord-canary.override {
      withVencord = true;
    })
  ];
}
