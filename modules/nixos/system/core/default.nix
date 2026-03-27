{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.system.core;
  locale = "en_AU.UTF-8";
in
{
  options.bery.system.core = {
    enable = mkEnableOption "core system settings across all hosts.";
  };

  config = mkIf cfg.enable {
    #! ===============================
    #! ========== NIX STUFF ==========
    #! ===============================
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
    };

    # Commented out in favour of nh.clean.enable
    # nix.gc.automatic = true;
    # nix.gc.dates = "daily";
    # nix.gc.options = "--delete-older-than 10d";

    # Auto update
    system.autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "-L" # print build logs
      ];
      dates = "02:00";
      randomizedDelaySec = "45min";
    };

    #! ================================
    #! ========== NETWORKING ==========
    #! ================================

    networking.networkmanager.enable = lib.mkDefault true;
    bery.services.avahi.enable = lib.mkDefault true;

    #! =======================================
    #! ========== TIMEZONE / LOCALE ==========
    #! =======================================
    time.timeZone = "Australia/Sydney";

    # Select internationalisation properties.
    i18n.defaultLocale = locale;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };

    #! =================================
    #! ========== SYSTEM PKGS ==========
    #! =================================
    environment.systemPackages = with pkgs; [
      git
      wget
      vim
    ];
  };
}
