{
  description = "Mufaro NixOS nya~";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

    prismlauncher.url = "github:PrismLauncher/PrismLauncher";

    zen-browser = {
      url = "github:ch4og/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };

    catppuccin-cava = {
      url = "github:catppuccin/cava";
      flake = false;
    };

    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };

    # Requires access to ghostty-org
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
    };
  };

  outputs =
    { nixpkgs
    , self
    , ...
    } @ inputs:
    let
      selfPkgs = import ./pkgs;
      username = "mufaro";
    in
    {
      overlays.default = selfPkgs.overlay;
      nixosConfigurations = import ./modules/core/default.nix
        {
          inherit self nixpkgs inputs username;
        };
    };
}
