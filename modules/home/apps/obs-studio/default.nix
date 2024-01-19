{pkgs, ...}: {
  programs.obs-studio.enable = true;

  programs.obs-studio.plugins = with pkgs; [
    obs-linuxbrowser
    obs-ndi
    obs-v4l2sink
  ];
}
