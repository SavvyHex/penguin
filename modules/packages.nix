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
    
    # Additional Unity dependencies (fixes crash)
    pciutils          # provides lspci command
    gtk3
    glib
    cairo
    pango
    atk
    gdk-pixbuf
    freetype
    fontconfig
    dbus
    nspr
    nss
    cups
    expat
    udev
    alsa-lib
    libGL
    libGLU
    mesa
    zlib
    libpulseaudio
    libcap
    
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
      pkgs.gtk3
      pkgs.glib
      pkgs.cairo
      pkgs.pango
      pkgs.atk
      pkgs.gdk-pixbuf
      pkgs.freetype
      pkgs.fontconfig
      pkgs.dbus
      pkgs.nspr
      pkgs.nss
      pkgs.cups
      pkgs.expat
      pkgs.udev
      pkgs.alsa-lib
      pkgs.libGL
      pkgs.libGLU
      pkgs.mesa
      pkgs.zlib
      pkgs.libpulseaudio
      pkgs.libcap
    ];
  };
  
  # Ensure DBus is available for Unity (fixes GLib-GIO-CRITICAL errors)
  services.dbus.enable = true;
  
  # Additional system settings for Unity
  programs.dconf.enable = true;
}
