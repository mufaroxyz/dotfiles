{ inputs
, username
, ...
}: {
  imports = [
    ./starship.nix
    ./zsh.nix
  ];
}
