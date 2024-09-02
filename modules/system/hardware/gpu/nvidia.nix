{ config, pkgs, ... }:
{

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      mesa
      libva
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    dynamicBoost.enable = false;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };


  services.xserver.videoDrivers = [ "nvidia" ];
}
