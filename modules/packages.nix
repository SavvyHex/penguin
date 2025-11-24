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
    sdl2
    sdl2_image
    sdl2_mixer
    sdl2_ttf
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
