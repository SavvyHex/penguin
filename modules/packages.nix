{ config, pkgs, ... }:

{
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    wget
    brave
    vscode
    git
    nodejs
    ulauncher
  ];

  # Programs that need special configuration
  programs.firefox.enable = true;
}
