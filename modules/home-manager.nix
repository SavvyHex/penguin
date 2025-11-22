{ config, pkgs, ... }:

{
  home.username = "savvyhex";
  home.homeDirectory = "/home/savvyhex";
  home.stateVersion = "24.11";

  # Home Manager packages
  home.packages = with pkgs; [
    # Add user-specific packages here
  ];

  # Programs configuration can go here
  programs.home-manager.enable = true;
}
