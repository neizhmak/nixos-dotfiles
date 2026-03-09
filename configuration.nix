{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/hardware.nix
    ./modules/system.nix
    ./modules/users.nix
    ./modules/packages.nix
    ./modules/desktop.nix
    ./modules/services.nix
  ];
}
