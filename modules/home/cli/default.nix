{ inputs
, username
, ...
}: {
  imports = [ (import ./git.nix) ]
    ++ [ (import ./ssh.nix) ]
    ++ [ (import ./shell) ]
    ++ [ (import ./scripts) ];
}
