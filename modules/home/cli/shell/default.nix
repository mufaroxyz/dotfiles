{ inputs
, username
, ...
}: {
  imports =
    [ (import ./starship.nix) ]
    ++ [ (import ./zsh.nix) ];
}
