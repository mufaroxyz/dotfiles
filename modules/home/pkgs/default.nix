{ inputs
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    eza # ls replacement
    entr # run command when files change
    file # file info

    fzf
    libreoffice
    nitch
    nix-prefetch-github
    ripgrep
    spotify
    spicetify-cli
    soundwireserver
    yazi
    gnome.zenity
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
    inputs.zen-browser.packages.${pkgs.system}.default
    krita
    easyeffects
    vesktop

    xwaylandvideobridge
    egl-wayland

    gcc
    gnumake

    libva
    bleachbit
    cmatrix
    gparted
    ffmpeg
    imv
    libnotify
    man-pages
    mpv
    ncdu
    openssl
    pamixer
    pavucontrol
    playerctl
    qalculate-gtk
    unzip
    wget
    xdg-utils
  ];
}
