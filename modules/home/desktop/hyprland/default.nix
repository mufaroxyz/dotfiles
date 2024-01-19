{inputs, ...}: {
  imports =
    [(import ./hyprland.nix)]
    ++ [(import ./hypr-config.nix)]
    ++ [(import ./senv.nix)]
    ++ [inputs.hyprland.homeManagerModules.default];
}
