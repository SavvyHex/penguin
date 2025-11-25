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
    steam
    proton-ge-bin
    mangohud
    goverlay
  ];

  # Programs that need special configuration
  programs.firefox.enable = true;
  
  # Steam configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  # Enable 32-bit support (required for Steam games)
  hardware.graphics.enable32Bit = true;
  services.pulseaudio.support32Bit = true;
}
