{ config, pkgs, lib, ... }:

let
  # Create Unity with FHS environment wrapper
  unityFHS = pkgs.buildFHSUserEnv {
    name = "unity-fhs";
    targetPkgs = pkgs: with pkgs; [
      unityhub
      # Core Unity dependencies
      gtk3
      gtk2
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
      libxkbcommon
      
      # X11 libraries
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
      
      # System utilities
      pciutils
      procps
      coreutils
      
      # Development tools
      mono
      dotnet-sdk_8
      gcc
      stdenv.cc.cc.lib
      
      # Additional libraries
      icu
      openssl
      krb5
      libsecret
      at-spi2-atk
      at-spi2-core
      libuuid
      libappindicator
      libnotify
      
      # Wayland support
      wayland
      
      # Audio
      pipewire
      
      # Utilities Unity uses
      xdotool
      wmctrl
      zenity
      gnome.zenity
    ];
    
    multiPkgs = pkgs: with pkgs; [
      # 32-bit support
      alsa-lib
      libpulseaudio
    ];
    
    runScript = "unityhub";
    
    profile = ''
      export UNITY_PATH=${pkgs.unityhub}
      export LD_LIBRARY_PATH=/usr/lib:/usr/lib32:$LD_LIBRARY_PATH
      export PATH=/usr/bin:$PATH
      export XDG_DATA_DIRS=/usr/share:$XDG_DATA_DIRS
    '';
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
    python3Packages.pygame
    spotify
    python3
    steam
    mangohud
    goverlay
    
    # Unity with FHS environment (replaces unityhub)
    unityFHS
    mono
    dotnet-sdk_8
    
    # Build tools
    gcc
    pkg-config
    cmake
    
    # System utilities
    pciutils
    xdotool
    wmctrl
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
  
  # Ensure DBus is available for Unity
  services.dbus.enable = true;
  
  # Additional system settings for Unity
  programs.dconf.enable = true;
}