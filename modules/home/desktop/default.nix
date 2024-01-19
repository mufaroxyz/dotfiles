{
  inputs,
  username,
  ...
}: {
  imports =
    [(import ./hyprland)]
    ++ [(import ./addons)];
}
