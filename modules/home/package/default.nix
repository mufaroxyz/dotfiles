{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    eza # ls replacement
    entr # perform actions when files change
    file # show file information

    fzf
    libreoffice
    nitch
    nix-prefetch-github
    prismlauncher # minecraft launcher
    ripgrep
    rnix-lsp
    soundwireserver
    spotify
    spicetify-cli
    cinnamon.nemo-with-extensions # file manager
    yazi # terminal file manager
    gnome.zenity

    xwaylandvideobridge #streaming discord

    # C / C++
    gcc
    gnumake

    libva
    bleachbit # cache cleaner
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
    inputs.alejandra.defaultPackage.${system}
  ];
}
