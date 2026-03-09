{ config, pkgs, ... }:

{
  # Загрузчик systemd-boot
  boot.loader.timeout = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  # Windows по умолчанию
  boot.loader.systemd-boot.extraEntries = {
    "windows.conf" = ''
      title Windows
      sort-key a-windows
      efi /EFI/windows-boot/bootmgfw.efi
    '';
  };

  boot.loader.systemd-boot.extraInstallCommands = ''
    ${pkgs.gnused}/bin/sed -i 's/^default .*/default windows.conf/' /boot/loader/loader.conf
  '';

  # Фикс Dual Boot
  system.activationScripts.copyWindowsBootloader = ''
    if [ -d /boot/EFI/windows/EFI/Microsoft ]; then
      ${pkgs.rsync}/bin/rsync -a /boot/EFI/windows/EFI/Microsoft/ /boot/EFI/Microsoft/
      mkdir -p /boot/EFI/windows-boot
      mv -f /boot/EFI/Microsoft/Boot/bootmgfw.efi /boot/EFI/windows-boot/bootmgfw.efi
    fi
  '';

  # Свежее ядро Linux
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Оптимизации ядра и фикс разрешения GDM
  boot.kernelParams = [
    "intel_idle.max_cstate=1"
    "libahci.ignore_sss=1"
    "mitigations=off"
    "nowatchdog"
    "page_alloc.shuffle=1"
    "pci=pcie_bus_perf"
    "quiet"
    "split_lock_detect=off"
    "threadirqs"
    "udev.log_level=3"
    "video=HDMI-A-1:1440x810@110"
  ];

  # Тихая загрузка Plymouth
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 3;
  boot.plymouth.enable = true;
}
