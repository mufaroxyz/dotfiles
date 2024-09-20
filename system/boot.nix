{ pkgs, ... }:
{
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_6_10;
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.extraModprobeConfig = ''options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3"\n'';
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];
}
