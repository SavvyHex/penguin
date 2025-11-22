{ config, pkgs, ... }:

{
  # Shell configuration and aliases
  programs.bash = {
    enable = true;
    interactiveShellInit = ''
      # Add your bash aliases here
      alias ll='ls -lah'
      alias la='ls -A'
      alias l='ls -CF'
      alias cd..='cd ..'
      alias ..='cd ..'
      
      # System management
      alias rebuild='sudo nixos-rebuild switch --flake ~/.config/nixos#penguin'
      alias rebuild-test='nixos-rebuild build --flake ~/.config/nixos#penguin'
    '';
  };

  # Zsh configuration (optional, commented out by default)
  # programs.zsh = {
  #   enable = true;
  #   interactiveShellInit = ''
  #     # Add your zsh aliases here
  #     alias ll='ls -lah'
  #   '';
  # };
}
