{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.calibre;
in
{
  options.bery.apps.calibre = {
    enable = mkEnableOption "ebook management software";
  };

  config = mkIf cfg.enable {
    programs.calibre.enable = true;
  };
}
