{ ... }:
let
  color = import ../../variables/colors.nix;
  window_manager = import ../../variables/window_manager.nix;
in
{
  wayland.windowManager.hyprland.settings = { };
}
