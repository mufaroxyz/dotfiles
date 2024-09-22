{ inputs
, username
, ...
}: {
  imports = [
    ./obs-studio.nix
    ./vscode.nix
  ];
}
