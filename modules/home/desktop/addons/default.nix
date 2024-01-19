{
  inputs,
  username,
  ...
}: {
  imports =
    [(import ./gaming)]
    ++ [(import ./gtk)]
    ++ [(import ./swaylock)]
    ++ [(import ./waybar)]
    ++ [(import ./wofi)]
    ++ [(import ./kitty)];
}
