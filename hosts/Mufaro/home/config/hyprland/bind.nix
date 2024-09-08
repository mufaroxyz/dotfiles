{ ... }: {
  wayland.windowManager.hyprland.settings = {
    "$terminal" = "kitty";
    "$fileManager" = "dolphin";
    "$browser" = "zen";
    "$menu" = "rofi -show drun";
    "$mod" = "SUPER";
    bind = [
      "$mod, Return, exec, $terminal"
      "$mod, C, killactive"
      "$mod, M, exit"
      "$mod, E, exec, $fileManager"
      "$mod, B, exec, $browser"
      '',Shift_L, Print, exec, grim -g "$(slurp -d)" - | wl-copy''
      ",Print, exec, grim - | wl-copy"
      "$mod, F, togglefloating"
      "$mod, BRACKETRIGHT, fullscreen"
      "$mod, SPACE, exec, $menu"
      "$mod, J, togglesplit"
    ] ++ (builtins.concatLists (builtins.genList
      (i:
        let ws = i + 1;
        in [
          "$mod, code:1${toString i}, split-workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, split-movetoworkspace, ${toString ws}"
        ]) 5));
    bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
  };
} 
