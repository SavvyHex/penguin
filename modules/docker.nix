{ config, pkgs, ... }:

{
  # Docker configuration for NixOS
  virtualisation.docker.enable = true;
  
  # Add docker daemon settings
  virtualisation.docker.daemon.settings = {
    userland-proxy = false;
  };

  # Add Docker Compose
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
