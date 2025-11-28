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
    vulkan-headers
    python3Packages.pygame
    spotify
    python3
    steam
    steam-run
    mangohud
    goverlay
    gamemode
    
    # Unity (run with: steam-run unityhub)
    unityhub
    mono
    dotnet-sdk_8
    
    # Additional Unity dependencies for steam-run
    gtk3
    gtk2
    glib
    pciutils
    xdotool
    wmctrl
    zenity
    
    # Build tools
    gcc
    pkg-config
    cmake
    gnumake
    
    # Gaming dependencies
    mesa
    libGL
    libGLU
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xorg.libXScrnSaver
    xorg.libXrandr
    libpng
    libpulseaudio
    libvorbis
    stdenv.cc.cc.lib
    libkrb5
    keyutils
  ];

  # Programs that need special configuration
  programs.firefox.enable = true;
  
  # Steam configuration for gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  
  # GameMode for better game performance
  programs.gamemode.enable = true;
  
  # Enable 32-bit support (required for Steam games and Unity)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  # Ensure DBus is available for Unity
  services.dbus.enable = true;
  
  # Additional system settings for Unity and gaming
  programs.dconf.enable = true;
}