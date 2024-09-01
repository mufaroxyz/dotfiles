{ pkgs, ... }:

{
	home.username = "mufaro";
	home.homeDirectory = "/home/mufaro";

	# wayland.windowManager.hyprland.enable = true;

	home.packages = with pkgs; [
		kitty
		vesktop
		grim
		slurp
		pavucontrol
		spotify
		fastfetch
		(pkgs.discord.override {
		    withOpenASAR = true;
			withVencord = true;
		})
	];

	programs.git = {
		enable = true;
		userName = "mufaroxyz";
		userEmail = "81554673+mufaroxyz@users.noreply.github.com";
		extraConfig = {
		    gpg.format = "ssh";
			user.signingKey = "~/.ssh/id_ed25519.pub";
			commit.gpgsign = true;
			url."ssh://git@".pushInsteadOf = "https://";
		};
	};

	programs.bash = {
		enable = true;
		enableCompletion = true;
	};



	home.stateVersion = "24.05";

	programs.home-manager.enable = true;
}
