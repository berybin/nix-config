{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.freecad;
in
{
  options.bery.apps.freecad = {
    enable = mkEnableOption "freecad";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      freecad
    ];
  };
}
