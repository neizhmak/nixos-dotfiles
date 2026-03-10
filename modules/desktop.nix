{
  config,
  pkgs,
  lib,
  ...
}:

let
  orchis-theme-custom = pkgs.orchis-theme.override {
    tweaks = [ "solid" "compact" "black" "submenu" ];
  };
in

{
  # GNOME и GDM
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GTK_THEME = "Orchis-Dark";
    # Фикс диалогов сохранения в Wayland
    XDG_DATA_DIRS = [
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    ];
  };

  # Репликация флага --libadwaita для Orchis-Dark
  environment.etc."xdg/gtk-4.0/gtk.css".source = "${orchis-theme-custom}/share/themes/Orchis-Dark/gtk-4.0/gtk.css";
  environment.etc."xdg/gtk-4.0/gtk-dark.css".source = "${orchis-theme-custom}/share/themes/Orchis-Dark/gtk-4.0/gtk-dark.css";
  environment.etc."xdg/gtk-4.0/assets".source = "${orchis-theme-custom}/share/themes/Orchis-Dark/gtk-4.0/assets";

  # Расширения GNOME
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
    orchis-theme-custom
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
