{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  swapDevices = [{
    device = "/swapfile";
    size = 32 * 1024; # 32GB
  }];

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
}
