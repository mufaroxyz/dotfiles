{ config, pkgs, ... }: {
  imports = [ ./bind.nix ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland-git.default;
    systemd.enable = true;
    systemd.variables = [ "--all" ];
    settings = {
      monitor = [
        ", 1920x1080@72,auto,auto"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      env = [
        "XCURSOR_THEME,BreezeX-RosePine-Linux"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct"
        "MOZ_ENABLE_WAYLAND,1"
      ];
    };
  };
}
