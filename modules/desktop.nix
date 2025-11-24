{ config, pkgs, ... }:

{
  # Display server and desktop environment
  services.xserver.enable = true;

  # GPU / Graphics configuration (recommended for Intel GPUs)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ mesa ];
  };

  # Use modesetting for modern Intel GPUs (recommended). For older Intel GPUs
  # you can switch this to "intel" to use xf86-video-intel.
  services.xserver.videoDrivers = [ "modesetting" ];

  # KDE Plasma 6
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Keymap configuration
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Audio with PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing support
  services.printing.enable = true;
}
