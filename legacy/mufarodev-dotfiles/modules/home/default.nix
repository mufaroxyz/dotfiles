{ inputs
, username
, ...
}: {
  imports = [ 
    ./apps
    ./cli
    ./desktop
    ./pkgs
  ];
}
