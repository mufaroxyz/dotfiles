{ inputs
, username
, ...
}: {
  imports = [
    ./git.nix
    ./shell
    ./scripts
    ./fastfetch
  ];
}
