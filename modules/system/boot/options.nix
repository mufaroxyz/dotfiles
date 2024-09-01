{ config, pkgs, ... }:
{
	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.kernelModules = ["kvm-intel"];
	boot.kernelParams = ["nvidia-drm.modeset=1" "nvidia-drm.fbdev=1"];
}
