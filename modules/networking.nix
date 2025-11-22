{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "deathstar";

  # Network management
  networking.networkmanager.enable = true;

  # Firewall configuration (disabled by default)
  # networking.firewall.enable = false;
  # networking.firewall.allowedTCPPorts = [ ];
  # networking.firewall.allowedUDPPorts = [ ];

  # Proxy configuration (optional)
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
