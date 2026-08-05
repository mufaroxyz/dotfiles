{ inputs, ... }: {
  imports = [
    ./hyprland.nix
    ./hyprland-config.nix
    ./senv.nix
    inputs.hyprland.homeManagerModules.default
  ];
}
