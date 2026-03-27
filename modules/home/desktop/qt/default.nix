{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.desktop.qt;
in
{
  options.bery.desktop.qt = {
    enable = mkEnableOption "qt";
  };

  config = mkIf cfg.enable {
    qt = {
      enable = true;
      style.name = "breeze";
    };
  };
}
