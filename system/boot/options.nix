{ pkgs, ... }:
{
	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.blacklistedKernelModules = ["nouveau"];
	boot.extraModprobeConfig = ''options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3"\n'';
	boot.kernelModules = ["kvm-intel"];
	boot.kernelParams = ["nvidia-drm.modeset=1" "nvidia-drm.fbdev=1"];
}