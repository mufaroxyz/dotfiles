{ pkgs, ... }:
let
  color = import ../../variables/colors.nix;
  window_manager = import ../../variables/window_manager.nix;
in
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    monitor = ",1920x1080@72,0x0,1";

    exec-once = [
      "systemctl --user import-environment"
      "hash dbus-update-activation-environment 2>/dev/null"
      "dbus-update-activation-environment --systemd"
      "rm-applet"
      "wl-paste --primary --watch wl-copy --primary --clear"
      "swaybg -m fill -i $(find ~/Pictures/Wallpapers/ -maxdepth 1 -type f)"
      "sleep 1 && swaylock"
      "hyprctl setcursor BreezeX-RosePine-Linux 22"
      "waybar"
      "mako"
    ];

    input = {
      kb_layout = "pl";
      numlock_by_default = false;
      follow_mouse = 1;
      sensitivity = 0.5;
      force_no_accel = 1;
    };

    misc = {
      disable_autoreload = true;
      disable_hyprland_logo = true;
      always_follow_on_dnd = true;
      layers_hog_keyboard_focus = true;
      animate_manual_resizes = true;
      enable_swallow = true;
      focus_on_activate = true;
    };

    general = {
      # sensitivity = 1.00;
      # apply_sens_to_raw = 1;
      gaps_in = 5;
      gaps_out = 10;
      border_part_of_window = false;
      border_size = 2;
      "col.active_border" = "rgb(cba6f7)";
      "col.inactive_border" = "rgba(565f89cc) rgba(9aa5cecc) 45deg";

      layout = "dwindle";
    };

    dwindle = {
      no_gaps_when_only = false;
      force_split = 0;
      special_scale_factor = 1.0;
      split_width_multiplier = 1.0;
      use_active_for_splits = true;
      pseudotile = "yes";
      preserve_split = "yes";
    };

    master = {
      # new_is_master = true;
      special_scale_factor = 1.0;
      no_gaps_when_only = false;
    };

    xwayland = {
      force_zero_scaling = true;
    };

    decoration = {
      rounding = 10;

      active_opacity = 0.90;
      inactive_opacity = 0.90;
      fullscreen_opacity = 1.0;

      blur = {
        enabled = true;

        size = 6;
        passes = 3;

        brightness = 1;
        contrast = 1.300000;
        ignore_opacity = true;
        noise = 0.014700;

        new_optimizations = true;

        xray = true;
      };

      drop_shadow = true;

      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 3;
      "col.shadow" = "rgba(00000055)";
    };


    animations = {
      enabled = true;

      bezier = [
        "wind, 0.25, 0.8, 0.25, 1.0"
        "winIn, 0.1, 1.0, 0.3, 1.0"
        "winOut, 0.3, 0.5, 0.5, 1.0"
        "linear, 1.0, 1.0, 1.0, 1.0"
      ];

      animation = [
        # Windows
        "windows, 1, 5, wind, slide" # window open
        "windowsIn, 1, 5, winIn, slide" # window close.
        "windowsOut, 1, 4, winOut, slide"
        "windowsMove, 1, 4, wind, slide"
        # Border animation: focus effect on window borders
        "border, 1, 1, linear" # fade in (open) -> layers and windows
        "borderangle, 1, 25, linear, loop" # fade out (close) -> layers and windows
        # Fade effects for smooth transitions
        "fade, 1, 7, default" # fade on changing activewindow for shadows
        # Workspace switching: fluid transitions between workspaces
        "workspaces, 1, 4, wind, slidefadehoriz 30%"
      ]; # everything in between, moving, dragging, resizing.
    };

    windowrulev2 = [
      # xwaylandvideobridge
      "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
      "noanim,class:^(xwaylandvideobridge)$"
      "noinitialfocus,class:^(xwaylandvideobridge)$"
      "maxsize 1 1,class:^(xwaylandvideobridge)$"
      "noblur,class:^(xwaylandvideobridge)$"

      "float,class:^(pavucontrol)$"
      "float,class:^(SoundWireServer)$"
      "float,class:^(file_progress)$"
      "float,class:^(confirm)$"
      "float,class:^(dialog)$"
      "float,class:^(download)$"
      "float,class:^(notification)$"
      "float,class:^(error)$"
      "float,class:^(confirmreset)$"
      "float,title:^(Open File)$"
      "float,title:^(branchdialog)$"
      "float,title:^(Confirm to replace files)$"
      "float,title:^(File Operation Progress)$"
    ];

    bind = [
      # list keybinds
      "$mainMod, F1, exec, show-keybinds"
      # keybinds
      "$mainMod, backspace, exec, kitty"
      "ALT, backspace, exec, kitty --title float_kitty"
      "$mainMod SHIFT, backspace, exec, kitty --start-as=fullscreen -o 'font_size=16'"
      "$mainMod, B, exec, firefox"
      "$mainMod, Q, killactive"
      "$mainMod, F, fullscreen, 0"
      "$mainMod SHIFT, F, fullscreen, 1"
      "$mainMod, V, togglefloating,"
      "$mainMod, D, exec, pkill wofi || wofi --show drun"
      "$mainMod, Escape, exec, swaylock"
      "$mainMod SHIFT, Escape, exec, shutdown-script"
      "$mainMod, P, pseudo,"
      "$mainMod, J, togglesplit, #dwindle"
      "$mainMod, E, exec, nemo"
      "$mainMod SHIFT, B, exec, pkill -SIGUSR1 .waybar-wrapped"
      "$mainMod, C, exec, hyprpicker -a"
      "$mainMod, G,exec, $HOME/.local/bin/toggle_layout"
      "$mainMod, W,exec, pkill wofi || wallpaper-picker"
      # switch focus
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # media and volume controls
      # "XF86AudioRaiseVolume,exec, pamixer -i 2"
      # "XF86AudioLowerVolume,exec, pamixer -d 2"
      # "XF86AudioMute,exec, pamixer -t"
      # "XF86AudioPlay,exec, playerctl play-pause"
      # "XF86AudioNext,exec, playerctl next"
      # "XF86AudioPrev,exec, playerctl previous"
      # "XF86AudioStop, exec, playerctl stop"
      "$mainMod, mouse_down, workspace, e-1"
      "$mainMod, mouse_up, workspace, e+1"

      # screenshot
      "$mainMod, Print, exec, grimblast --cursor copy area"
      ",Print, exec, grimblast --cursor copy screen"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };

  wayland.windowManager.hyprland.extraConfig = ''
    ${
      builtins.concatStringsSep "\n"
      (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
          in ''
            bind = $mainMod, ${ws}, workspace, ${toString (x + 1)}
            bind = $mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
          ''
        )
        10)
    }
  '';
}



