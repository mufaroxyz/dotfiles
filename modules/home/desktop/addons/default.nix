{ inputs
, username
, ...
}: {
  imports = [ (import ./gtk.nix) ]
    ++ [ (import ./swaylock.nix) ]
    ++ [ (import ./waybar) ]
    ++ [ (import ./wofi) ]
    ++ [ (import ./gaming.nix) ]
    ++ [ (import ./kitty.nix) ];
}
