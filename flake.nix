{
  description = "Mufaro's Nix configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pinned compatibility inputs for the archived Linux desktop.
    nixpkgs-linux.url = "github:NixOS/nixpkgs/5633bcff0c6162b9e4b5f1264264611e950c8ec7";
    nur.url = "github:nix-community/NUR/e6a320542e9733a4adb0434ffd2b57ff315b85ce";

    home-manager-linux = {
      url = "github:nix-community/home-manager/64c6325b28ebd708653dd41d88f306023f296184";
      inputs.nixpkgs.follows = "nixpkgs-linux";
    };

    hypr-contrib = {
      url = "github:hyprwm/contrib/1e531dc49ad36c88b45bf836081a7a2c8927e072";
      inputs.nixpkgs.follows = "nixpkgs-linux";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?ref=refs/heads/main&rev=5c3bd8e93d9f25be3e16a0445ba6fce8d30b6d73&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs-linux";
    };

    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher/f239f4c17c80e88aa12635e142f7829688f122c3";
      inputs.nixpkgs.follows = "nixpkgs-linux";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/5611dd61df02e0bc5d62bb3f5388821d8854faff";
      inputs.nixpkgs.follows = "nixpkgs-linux";
    };

    zen-browser = {
      url = "github:ch4og/zen-browser-flake/6124e356baf28ff3e9d31ee1d61309b1046974e8";
      inputs.nixpkgs.follows = "nixpkgs-linux";
    };

    catppuccin-starship = {
      url = "github:catppuccin/starship/3c4749512e7d552adf48e75e5182a271392ab176";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    {
      # ponytail: temporary compatibility output; delete with the legacy rewrite.
      overlays.default = _: _: { };

      darwinConfigurations.Odette = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/Odette/default.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mufaro = ./hosts/Odette/home.nix;
            };
          }
        ];
      };

      nixosConfigurations.nixos = inputs.nixpkgs-linux.lib.nixosSystem {
        specialArgs = {
          inherit self;
          inputs = inputs // {
            home-manager = inputs.home-manager-linux;
          };
          username = "mufaro";
        };
        modules = [ ./hosts/nixos ];
      };

      formatter =
        nixpkgs.lib.genAttrs
          [
            "aarch64-darwin"
            "aarch64-linux"
            "x86_64-linux"
          ]
          (
            system:
            nixpkgs.legacyPackages.${system}.nixfmt-tree.override {
              settings.formatter.nixfmt.excludes = [ "legacy/**" ];
            }
          );
    };
}
