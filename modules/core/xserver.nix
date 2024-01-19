{
  pkgs,
  username,
  ...
}: {
  services.xserver = {
    enable = true;
    layout = "pl";

    libinput.enable = true;

    displayManager.sddm.enable = true;
    displayManager.defaultSession = "hyprland";
    displayManager.autoLogin = {
      enable = true;
      user = "${username}";
    };
  };

  # Prevents getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

  environment.systemPackages = [
    pkgs.libva
  ];
}
