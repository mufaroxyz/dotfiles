{ pkgs, username, inputs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${username} = { pkgs, ... }: {
    imports = [
      (import ./pkgs.nix { inherit pkgs inputs; })
      (import ./config.nix { inherit pkgs inputs; })
    ];

    home.homeDirectory = "/home/${username}";

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 16;
    };
    home.stateVersion = "24.05";
  };
}
