{
  custom ? {
    font = "JetBrainsMono Nerd Font";
    fontsize = "12";
    primary_accent = "cba6f7";
    secondary_accent = "89b4fa";
    tertiary_accent = "f5f5f5";
    background = "11111B";
    opacity = ".85";
    cursor = "Numix-Cursor";
  },
  ...
}: {
  programs.waybar.style = ./style.css;

  programs.waybar.settings.mainBar = {
    layer = "bottom";
    position = "top";
    height = 48;
    include = ./modules;
    modules-left = [
      "custom/launcher#nix"
      "custom/three-dots-seperator" 
      "cpu#icon" 
      "memory#icon" 
      "mpris"
    ];
    modules-center = ["hyprland/workspaces#numbers"];
    modules-right = [
      "cava#right"
      "pulseaudio#icon" 
      "custom/updates" 
      "group/clock" 
      "tray"
      "custom/power-button"
    ];
  };
}