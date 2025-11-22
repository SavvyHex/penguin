# Penguin NixOS Configuration

A modular, flake-based NixOS configuration for the `deathstar` machine with organized, maintainable settings.

## Overview

This repository contains a complete NixOS system configuration managed through Nix Flakes, providing reproducible and declarative system management. The configuration is organized into modular files for easy maintenance and customization.

### What is NixOS?

NixOS is a Linux distribution built on top of the Nix package manager. It allows you to declare your entire system configuration in code, making it:
- **Reproducible**: Same configuration = same system across machines
- **Declarative**: You describe *what* you want, not *how* to get it
- **Reliable**: Easy to rollback to previous system states
- **Maintainable**: Configuration is version-controlled and documented

### What are Flakes?

Nix Flakes provide a standardized way to package Nix code with explicit inputs/outputs and lock files. They ensure reproducibility by pinning exact versions of dependencies (like `nixpkgs`).

## Directory Structure

```
.
├── flake.nix                    # Flake definition with inputs/outputs
├── flake.lock                   # Lock file (tracks exact package versions)
├── configuration.nix            # Main config file (imports modules)
├── hardware-configuration.nix   # Hardware-specific settings (generated)
├── modules/                     # Modular configuration files
│   ├── boot.nix                 # Bootloader configuration
│   ├── desktop.nix              # Desktop environment (KDE Plasma, audio, display)
│   ├── localization.nix         # Timezone and locale settings
│   ├── networking.nix           # Network configuration
│   ├── nix.nix                  # Nix settings and system version
│   ├── packages.nix             # System packages and programs
│   ├── shell.nix                # Shell configuration and aliases
│   └── users.nix                # User account management
├── .gitignore                   # Git ignore patterns
└── README.md                    # This file
```

## Quick Start

### Prerequisites

- NixOS installed on your system
- Git installed
- `sudo` access for system rebuilds

### Building Your Configuration

To apply this configuration to your system:

```bash
# Clone or navigate to this directory
cd /path/to/penguin

# Build the system (without applying changes)
nixos-rebuild build --flake .#deathstar

# Apply the configuration to your system
sudo nixos-rebuild switch --flake .#deathstar
```

### Flake Command Format

```
nixos-rebuild <action> --flake <flake-location>#<configuration-name>
```

- **Actions**:
  - `build`: Build without applying
  - `switch`: Build and apply immediately
  - `boot`: Build and apply on next reboot
  - `test`: Build and test in a temporary environment
  
- **Flake location**: `.` (current directory) or full path
- **Configuration name**: `deathstar` (defined in `flake.nix`)

## Configuration Guide

### Adding Packages

Edit `modules/packages.nix` to add system-wide packages:

```nix
environment.systemPackages = with pkgs; [
  vim
  wget
  brave
  vscode
  git
  # Add your packages here
  ripgrep    # Example: fast grep replacement
  fd         # Example: fast find replacement
];
```

To find package names, search NixOS packages:
```bash
nix search nixpkgs <package-name>
# Example: nix search nixpkgs python
```

### Adding Shell Aliases

Edit `modules/shell.nix` to add bash aliases:

```nix
programs.bash = {
  enable = true;
  interactiveShellInit = ''
    # Add your bash aliases here
    alias ll='ls -lah'
    alias la='ls -A'
    alias l='ls -CF'
    alias cd..='cd ..'
    alias ..='cd ..'
    
    # Add more aliases like:
    alias gs='git status'
    alias ga='git add'
    alias gc='git commit'
  '';
};
```

To enable Zsh instead, uncomment and configure the Zsh section in `modules/shell.nix`.

### Changing System Settings

Each module handles a specific aspect:

- **`modules/boot.nix`**: Bootloader (GRUB, systemd-boot)
- **`modules/desktop.nix`**: Display server, desktop environment (KDE Plasma 6), audio
- **`modules/localization.nix`**: Timezone, locale, language settings
- **`modules/networking.nix`**: Hostname, network manager, firewall
- **`modules/nix.nix`**: Nix experimental features, unfree packages, system version
- **`modules/users.nix`**: User accounts and groups
- **`modules/packages.nix`**: System packages and programs

Edit the relevant module and rebuild:

```bash
sudo nixos-rebuild switch --flake .#deathstar
```

### Changing Timezone

Edit `modules/localization.nix`:

```nix
time.timeZone = "Your/Timezone";  # Change this
```

Find your timezone:
```bash
timedatectl list-timezones
```

### Adding a New User

Edit `modules/users.nix`:

```nix
users.users.<username> = {
  isNormalUser = true;
  description = "User Full Name";
  extraGroups = [ "networkmanager" "wheel" ];
  packages = with pkgs; [
    # User-specific packages
  ];
};
```

After rebuilding, set the password:
```bash
sudo passwd <username>
```

### Installing Programs with User-Specific Packages

You can add packages specific to a user in `modules/users.nix`:

```nix
users.users.savvyhex = {
  isNormalUser = true;
  description = "Saketh Pai";
  extraGroups = [ "networkmanager" "wheel" ];
  packages = with pkgs; [
    kdePackages.kate
    vscode
    # Add more user packages here
  ];
};
```

Or add them to the system packages in `modules/packages.nix` to make them available to all users.

### Enabling Additional Programs

Some programs have special configuration options. Examples:

```nix
# Firefox with specific configuration
programs.firefox.enable = true;

# Git configuration
programs.git.enable = true;
programs.git.config = {
  init.defaultBranch = "main";
  user.name = "Your Name";
  user.email = "your@email.com";
};

# Vim configuration
programs.vim.enable = true;
```

Add these to `modules/packages.nix` or create a new module for program-specific settings.

## Creating New Modules

To keep your configuration organized, create new modules for specific features:

1. Create a new file in `modules/`:
```bash
touch modules/development.nix
```

2. Add configuration:
```nix
{ config, pkgs, ... }:

{
  # Your development tools configuration
  environment.systemPackages = with pkgs; [
    nodejs
    python311
    rustup
  ];
}
```

3. Import it in `configuration.nix`:
```nix
imports = [
  # ... existing imports ...
  ./modules/development.nix
];
```

4. Rebuild:
```bash
sudo nixos-rebuild switch --flake .#deathstar
```

## Useful Commands

### System Management

```bash
# View all system generations
nixos-rebuild list-generations

# Switch to a previous generation
sudo nixos-rebuild switch --rollback

# Remove old generations
nix-collect-garbage -d

# Check Nix store usage
du -sh /nix/store
```

### Package Management

```bash
# Search for a package
nix search nixpkgs <name>

# Check available versions
nix search nixpkgs <name> --json | jq

# Show package dependencies
nix-store -q --tree $(nix-build --no-out-link -A <package> '<nixpkgs>')
```

### Configuration Updates

```bash
# Update flake inputs to latest versions
nix flake update

# Update specific input
nix flake update nixpkgs

# Check what will change
nixos-rebuild build --flake .#deathstar
# Review changes, then apply:
sudo nixos-rebuild switch --flake .#deathstar
```

## System Information

This configuration uses:
- **System**: x86_64-linux
- **Desktop Environment**: KDE Plasma 6
- **Display Server**: X11
- **Audio**: PipeWire with ALSA support
- **Network**: NetworkManager
- **Bootloader**: systemd-boot with EFI
- **Locale**: en_IN (India)
- **Timezone**: Asia/Kolkata

## Debugging

If a rebuild fails:

1. **Check the error message** - NixOS provides detailed error messages
2. **Verify syntax** - Use `nix eval` to check Nix syntax:
   ```bash
   nix eval --impure .#nixosConfigurations.deathstar.system
   ```
3. **Review recent changes** - Check git diff:
   ```bash
   git diff
   ```
4. **Look at the full trace**:
   ```bash
   nixos-rebuild switch --flake .#deathstar --show-trace
   ```

## Version Control

All configuration is version-controlled with Git. Always commit changes:

```bash
git add .
git commit -m "description of changes"
```

This allows you to:
- Track configuration history
- Revert unwanted changes
- Share configurations across machines

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Nixpkgs Packages](https://search.nixos.org/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [NixOS Wiki](https://nixos.wiki/)

## License

This configuration is provided as-is. Modify and use as needed for your system.

---

Happy declarative system management! 🐧
