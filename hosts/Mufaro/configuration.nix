{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

	services.fstrim.enable = true;
	services.xserver.enable = true;

    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    };

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
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    inputs.zen-browser.packages.${pkgs.system}.default
    rose-pine-cursor
  ];

  environment.variables.EDITOR = "nvim";

  programs.gamemode.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

    programs.ssh = {
		knownHostsFiles = [
			(pkgs.writeText "github.keys" ''
			github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
			github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
			github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=
			'')
		];
	};

  services.openssh.enable = true;

  system.stateVersion = "24.05";
}
