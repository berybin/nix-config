{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.apps.partitionmanager;
in
{
  options.bery.apps.partitionmanager = {
    enable = lib.mkEnableOption "KDE partitionmanager";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ kdePackages.partitionmanager ];
  };
}
