{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.suites.office;
in
{
  options.bery.suites.office = {
    enable = mkEnableOption "office and productivity programs";
  };

  config = mkIf cfg.enable {

    bery.apps = {
      okular.enable = true;
      calibre.enable = true;
      libreoffice.enable = true;
    };

  };
}
