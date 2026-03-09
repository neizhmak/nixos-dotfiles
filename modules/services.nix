{ config, pkgs, ... }:

{
  # Автозапуск эквалайзера JamesDSP
  systemd.user.services.jamesdsp = {
    description = "JamesDSP Audio Processor";
    wantedBy = [ "graphical-session.target" ];
    after = [ "pipewire.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.jamesdsp}/bin/jamesdsp --tray";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  # Утилита Throne с перехватом трафика
  programs.throne.enable = true;
  programs.throne.tunMode.enable = true;
}
