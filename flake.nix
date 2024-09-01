{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    prismlauncher.url = "github:PrismLauncher/PrismLauncher";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
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
              ./hosts/Mufaro/configuration.nix
	      ./modules/system

	      home-manager.nixosModules.home-manager
	      {
		home-manager = {
		  extraSpecialArgs = {
		    inherit inputs;
		  };
		  useGlobalPkgs = true;
		  useUserPackages = true;
		  backupFileExtension = "backup";
		  users.mufaro = import ./hosts/Mufaro/home.nix;
	        };
	      }
	    ];
	  };
	};

  };
}
