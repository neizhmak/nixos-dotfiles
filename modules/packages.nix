{ config, pkgs, ... }:

{
  # Разрешение закрытого ПО
  nixpkgs.config.allowUnfree = true;

  # Подмена пакетов (самая последняя версия antigravity)
  nixpkgs.overlays = [
    (final: prev: {
      antigravity = prev.antigravity.overrideAttrs (
        oldAttrs:
        let
          latestData = builtins.fromJSON (
            builtins.readFile (
              builtins.fetchurl "https://antigravity-auto-updater-974169037036.us-central1.run.app/api/update/linux-x64/stable/latest"
            )
          );
        in
        {
          version = builtins.head (builtins.match ".*antigravity/stable/([0-9.]+)-[0-9]+.*" latestData.url);
          src = prev.fetchurl {
            url = latestData.url;
            sha256 = latestData.sha256hash;
          };
        }
      );
    })
  ];

  # Fix Antigravity "waiting for command completion"
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    icu
    openssl
];

  # Программы пользователя
  users.users.user.packages = with pkgs; [
    antigravity
    fastfetch
    jamesdsp
    micro
    nixfmt
    vivaldi
    git
    rustup
    qemu
    python3
    gcc
    gemini-cli
    nodejs
    cargo-modules
  ];
}
