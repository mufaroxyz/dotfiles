{ inputs, ... }: {
  imports =
    [ (import ./hyprland.nix) ]
    ++ [ (import ./hyprland-config.nix) ]
    ++ [ (import ./senv.nix) ]
    ++ [ inputs.hyprland.homeManagerModules.default ];
}
