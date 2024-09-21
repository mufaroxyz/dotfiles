{ inputs
, username
, ...
}: {
  imports =
    [ (import ./obs-studio.nix) ]
    ++ [ (import ./vscode.nix) ];
}
