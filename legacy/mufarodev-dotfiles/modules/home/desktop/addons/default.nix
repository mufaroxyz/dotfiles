{ inputs
, username
, ...
}: {
  imports = [
    ./gtk.nix
    ./swaylock.nix
    ./waybar
    ./wofi
    ./gaming.nix
    ./kitty.nix
  ];
}
