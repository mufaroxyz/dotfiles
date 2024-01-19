{
  inputs,
  username,
  ...
}: {
  imports =
    [(import ./starship)]
    ++ [(import ./zsh)];
}
