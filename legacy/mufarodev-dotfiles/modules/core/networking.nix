{ pkgs, ... }: {
  networking = {
    hostName = "Mufaro";
    networkmanager = {
      enable = true;
    };
    nameservers = [ "1.1.1.1" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 59010 59011 ];
      allowedUDPPorts = [ 59010 59011 ];
    };
  };
}
