{
  config,
  pkgs,
  lib,
  ...
}:

{
  # GNOME и GDM
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  # Фикс диалогов сохранения в Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_DATA_DIRS = [
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    ];
  };

  # Расширения GNOME
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
  ];

  # Удаление лишнего софта GNOME
  environment.gnome.excludePackages = with pkgs; [
    atomix
    baobab
    cheese
    epiphany
    evince
    geary
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-connections
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-photos
    gnome-remote-desktop
    gnome-tour
    gnome-weather
    hitori
    iagno
    seahorse
    simple-scan
    snapshot
    tali
    totem
    yelp
  ];

  # Настройки dconf (шорткаты и кнопка питания)
  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings."org/gnome/desktop/wm/keybindings" = {
        switch-input-source = [
          "<Shift>Alt_L"
          "<Super>space"
        ];
        switch-input-source-backward = [
          "<Alt>Shift_L"
          "<space>Super"
        ];
      };
    }
  ];
}
