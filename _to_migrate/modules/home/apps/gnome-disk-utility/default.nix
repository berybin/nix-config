{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.apps.gnome-disk-utility;
in
{
  options.bery.apps.gnome-disk-utility = {
    enable = lib.mkEnableOption "gnome-disk-utility";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ gnome-disk-utility ];
  };
}
