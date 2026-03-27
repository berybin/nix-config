{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.blender;
in
{
  options.bery.apps.blender = {
    enable = mkEnableOption "blender";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      blender
    ];
  };
}
