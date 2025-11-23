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
    spotify
    python3
  ];

  # Programs that need special configuration
  programs.firefox.enable = true;
}
