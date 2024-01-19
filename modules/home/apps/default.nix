{
  inputs,
  username,
  ...
}: {
  imports =
    [(import ./audacious)]
    ++ [(import ./discord-canary)]
    ++ [(import ./firefox)]
    ++ [(import ./obs-studio)]
    ++ [(import ./vscode)];
}
