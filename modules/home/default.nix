{ inputs
, username
, ...
}: {
  imports = [ (import ./apps) ]
    ++ [ (import ./cli) ]
    ++ [ (import ./tui) ]
    ++ [ (import ./desktop) ]
    ++ [ (import ./package) ];
}
