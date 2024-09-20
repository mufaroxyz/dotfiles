{ pkgs
, config
, ...
}: {
  hardware.graphics = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      mesa
      vaapiVdpau
    ];
  };

  swapDevices = [{
    device = "/swapfile";
    size = 32 * 1024; # 32GB
  }];


  powerManagement.cpuFreqGovernor = "performance";
}
