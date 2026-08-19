{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.suites.common-legacy;
in
{
  options.bery.suites.common-legacy = {
    enable = mkEnableOption "common packages";
  };

  config = mkIf cfg.enable {

    # for packages that don't need any config
    home.packages = with pkgs; [

      # apps
      obsidian
      gimp
      discord
      google-chrome
      qbittorrent
      vlc
      # rpi-imager
      puddletag
      hardinfo2 # device manager equivalent
      audacity

    ];
  };
}
