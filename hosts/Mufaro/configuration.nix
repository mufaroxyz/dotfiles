{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

	services.fstrim.enable = true;
	services.xserver.enable = true;

	programs.hyprland.enable = true;

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-gtk
		];
	};

	services.xserver.xkb.layout = "pl";

	nixpkgs.config.allowUnfree = true;

  users.users.mufaro = {
    isNormalUser = true;
    description = "Mufaro";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    packages = with pkgs; [
      firefox
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    rofi
    wofi
    neovim
    zed-editor
    gamemode
    libnotify
    dunst
    wl-clipboard
    egl-wayland
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
  ];

  environment.variables.EDITOR = "nvim";

  programs.gamemode.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  system.stateVersion = "24.05";
}
