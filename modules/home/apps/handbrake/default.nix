{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.handbrake;
in
{
  options.bery.apps.handbrake = {
    enable = mkEnableOption "handbrake";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      handbrake
    ];
  };
}
