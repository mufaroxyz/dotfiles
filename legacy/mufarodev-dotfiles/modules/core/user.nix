{ pkgs
, inputs
, username
, ...
}:
let
  packages = with pkgs; [
    fish
  ];
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username; };
    users.${username} = {
      imports = [ (import ./../home) ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  nix.settings.allowed-users = [ "${username}" ];
}
