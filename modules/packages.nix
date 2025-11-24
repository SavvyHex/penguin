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
    godot
    blender
    gimp
    imagemagick
    ffmpeg
    SDL2
    SDL2_image
    SDL2_mixer
    SDL2_ttf
    assimp
    openal
    vulkan-loader
    vulkan-tools
    python3Packages.pygame
    spotify
    python3
  ];

  # Programs that need special configuration
  programs.firefox.enable = true;
}
