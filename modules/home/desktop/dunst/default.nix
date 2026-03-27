{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.desktop.dunst;
in
{
  options.bery.desktop.dunst = {
    enable = mkEnableOption "dunst";
  };

  config = mkIf cfg.enable {
    services.dunst.enable = true;
  };
}
