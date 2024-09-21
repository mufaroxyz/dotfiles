{ pkgs
, username
, ...
}: {
  services.displayManager = {
    enable = true;


    sddm.enable = true;
    defaultSession = "hyprland";
    # displayManager.autoLogin = {
    #   enable = true;
    #   user = "${username}";
    # };
  };

  services.xserver = {
    enable = true;
    xkb.layout = "pl";
  };
  services.libinput.enable = true;

  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

  environment.systemPackages = [
    pkgs.libva
  ];
}