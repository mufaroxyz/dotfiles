{
  inputs,
  username,
  ...
}: {
  imports =
    [(import ./bat)]
    ++ [(import ./btop)]
    ++ [(import ./mako)]
    ++ [(import ./micro)]
    ++ [(import ./nvim)];
}
