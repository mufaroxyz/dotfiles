{
  inputs,
  username,
  ...
}: {
  imports =
    [(import ./extra)]
    ++ [(import ./scripts)]
    ++ [(import ./shell)];
}
