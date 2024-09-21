{ inputs
, username
, ...
}: {
  imports = [ (import ./git.nix) ]
    ++ [ (import ./shell) ]
    ++ [ (import ./scripts) ];
}
