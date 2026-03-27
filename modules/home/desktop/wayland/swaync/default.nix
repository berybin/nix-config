{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.desktop.wayland.swaync;
in
{
  options.bery.desktop.wayland.swaync = {
    enable = mkEnableOption "swaync";
  };

  config = mkIf cfg.enable {
    services.swaync.enable = true;
  };
}
