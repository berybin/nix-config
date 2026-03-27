{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.dbeaver;
in
{
  options.bery.apps.dbeaver = {
    enable = mkEnableOption "SQL client";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dbeaver-bin
    ];
  };
}
