{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.btop;
in
{
  options.bery.tools.btop = {
    enable = mkEnableOption "btop";
  };

  config = mkIf cfg.enable {
    programs.btop.enable = true;
  };
}
