{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.libreoffice;
in
{
  options.bery.apps.libreoffice = {
    enable = mkEnableOption "libreoffice program suite";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice-qt6-fresh
    ];
  };

}
