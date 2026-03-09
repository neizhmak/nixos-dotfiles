{ config, pkgs, ... }:

{
  # Часовой пояс
  time.timeZone = "Europe/Moscow";

  # Русский язык
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Автообновление
  system.autoUpgrade.enable = true;

  # Оптимизация и очистка хранилища Nix
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 7d";

  # Авто-настройка приоритетов процессов
  services.ananicy.enable = true;
  services.ananicy.package = pkgs.ananicy-cpp;
  services.ananicy.rulesProvider = pkgs.ananicy-rules-cachyos;

  # Системная шина и балансировка прерываний
  services.dbus.implementation = "broker";
  services.irqbalance.enable = true;

  # Отключение локальных мануалов
  documentation.nixos.enable = false;
}
