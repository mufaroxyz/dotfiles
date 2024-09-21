{ inputs
, username
, ...
}: {
  imports = [ (import ./apps) ]
    ++ [ (import ./cli) ]
    ++ [ (import ./desktop) ]
    ++ [ (import ./pkgs) ];
}
