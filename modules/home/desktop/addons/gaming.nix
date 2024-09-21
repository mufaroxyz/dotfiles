{ pkgs
, config
, inputs
, ...
}: {
  home.packages = with pkgs; [
    gamemode
    gamescope
    winetricks
    protonup-qt
    _2048-in-terminal
    vitetris
    nethack
    celeste-classic
    celeste-classic-pm
    gzdoom
  ];
}
