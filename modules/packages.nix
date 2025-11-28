{ config, pkgs, lib, ... }:

let
  # Custom Unity Hub with proper FHS environment
  unity-hub-fhs = pkgs.buildFHSEnv {
    name = "unity-hub";
    
    targetPkgs = pkgs: (with pkgs; [
      # Unity Hub itself
      unityhub
      
      # Core system libraries
      glibc
      gcc-unwrapped
      
      # GTK and GUI libraries
      gtk3
      gtk2
      glib
      cairo
      pango
      atk
      gdk-pixbuf
      
      # X11 and graphics
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXi
      xorg.libXext
      xorg.libXrender
      xorg.libXfixes
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libxcb
      xorg.libXScrnSaver
      xorg.libSM
      xorg.libICE
      libxkbcommon
      
      # OpenGL
      libGL
      libGLU
      mesa
      
      # Audio
      alsa-lib
      libpulseaudio
      pipewire
      
      # Fonts and text rendering
      freetype
      fontconfig
      harfbuzz
      
      # System
      dbus
      systemd
      udev
      
      # Networking and security
      nspr
      nss
      openssl
      
      # Other dependencies
      cups
      expat
      zlib
      libcap
      icu
      krb5
      libsecret
      at-spi2-atk
      at-spi2-core
      libuuid
      libappindicator
      libnotify
      
      # Development
      mono
      dotnet-sdk_8
      
      # Wayland
      wayland
      
      # Utilities
      pciutils
      procps
      coreutils
      xdotool
      wmctrl
      zenity
      
      # Additional deps that Unity Editor might need
      stdenv.cc.cc.lib
      libunwind
      elfutils
      lttng-ust
      numactl
      
      # File system and inotify support
      inotify-tools
      glibc
      
      # Additional missing deps
      gsettings-desktop-schemas
      glib-networking
      libsoup
      libsoup_3
      
      # More graphics deps
      vulkan-headers
      libdrm
      libva
      libvdpau
    ]);
    
    multiPkgs = pkgs: (with pkgs; [
      # 32-bit libraries for Unity
      alsa-lib
      libpulseaudio
      libGL
      libGLU
      mesa
      zlib
      stdenv.cc.cc.lib
    ]);
    
    runScript = "unityhub";
    
    profile = ''
      export LD_LIBRARY_PATH=/usr/lib:/usr/lib32:$LD_LIBRARY_PATH
      export PATH=/usr/bin:$PATH
      export XDG_DATA_DIRS=/usr/share:$XDG_DATA_DIRS
      
      # Fix GLib/DBus errors
      export GIO_MODULE_DIR="${pkgs.glib-networking}/lib/gio/modules"
      export GSETTINGS_SCHEMA_DIR="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas"
      export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
      
      # Unity-specific environment variables
      export UNITY_NOGRAPHICS=0
      export UNITY_MIXED_CALLSTACK=1
      
      # Disable sandboxing which can cause crashes
      export UNITY_DISABLE_SANDBOXING=1
    '';
    
    meta = {
      description = "Unity Hub with FHS environment";
    };
  };
in
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
    
    # Unity Hub with FHS wrapper
    unity-hub-fhs
    
    # Still include steam-run as fallback
    steam-run
    
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