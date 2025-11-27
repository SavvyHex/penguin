{ config, pkgs, lib, ... }:

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
    mangohud
    goverlay
    
    # Unity Hub and Dependencies
    unityhub
    mono
    dotnet-sdk_8
    
    # Required libraries for Unity
    libxcursor
    libxrandr
    libxinerama
    libxi
    libxext
    libx11
    libxkbcommon
    icu
    xdotool
    wmctrl
    zenity
    
    # Build tools
    gcc
    pkg-config
    cmake
  ];

  # Programs that need special configuration
  programs.firefox.enable = true;
  
  # Steam configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  
  # Enable 32-bit support (required for Steam games and Unity)
  hardware.graphics.enable32Bit = true;
  services.pulseaudio.support32Bit = true;
  
  # Environment variables for Unity
  environment.variables = {
    LD_LIBRARY_PATH = lib.makeLibraryPath [
      pkgs.libxcursor
      pkgs.libxrandr
      pkgs.libxinerama
      pkgs.libxi
      pkgs.libxext
      pkgs.libx11
      pkgs.libxkbcommon
      pkgs.icu
    ];
  };
}
