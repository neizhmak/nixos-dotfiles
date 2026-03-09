{ config, pkgs, ... }:

{
  # Управление сетью
  networking.networkmanager.enable = true;

  # Аппаратное ускорение видео Intel
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-vaapi-driver
    libvdpau-va-gl
  ];

  environment.sessionVariables = {
    INTEL_DEBUG = "noccs";
    LIBVA_DRIVER_NAME = "iHD";
  };

  # Оптимизации Btrfs
  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "monthly";
  fileSystems."/".options = [
    "compress=zstd"
    "discard=async"
    "noatime"
    "space_cache=v2"
  ];

  # Сжатие памяти ZRAM (вместо swap)
  zramSwap.enable = true;
  zramSwap.algorithm = "lz4";

  # Аудио Pipewire (RTKit для приоритета)
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
}
