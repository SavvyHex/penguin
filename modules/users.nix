{ config, pkgs, ... }:

{
  # User accounts
  users.users.savvyhex = {
    isNormalUser = true;
    description = "Saketh Pai";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
}
