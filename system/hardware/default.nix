{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
}
