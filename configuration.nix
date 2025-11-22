# NixOS Configuration
# This file imports modular configuration files for better organization

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    
    # Modular configuration
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/docker.nix
    ./modules/localization.nix
    ./modules/networking.nix
    ./modules/nix.nix
    ./modules/packages.nix
    ./modules/shell.nix
    ./modules/users.nix
  ];
}
