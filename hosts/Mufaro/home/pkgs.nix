{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    vesktop
    grim
    slurp
    pavucontrol
    spotify
    fastfetch
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    krita
    wf-recorder
    obs-studio
    btop
    nixpkgs-fmt
    nvtopPackages.full
    easyeffects
  ];
}
