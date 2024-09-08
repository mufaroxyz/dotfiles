{
  description = "Mufaro's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

    # Requires access to ghostty-org
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
    };
  };

  outputs = inputs@{ home-manager, nixpkgs, ... }: {

    nixosConfigurations = {
      Mufaro = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/Mufaro
          ./system
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };

  };
}
