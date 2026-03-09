{ config, pkgs, ... }:

{
  # Обычный пользователь с правами sudo (wheel) и сети
  users.users.user.isNormalUser = true;
  users.users.user.description = "User";
  users.users.user.extraGroups = [
    "networkmanager"
    "wheel"
  ];

  # sudo без пароля для wheel
  security.sudo.wheelNeedsPassword = false;
}
