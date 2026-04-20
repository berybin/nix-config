{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.apps.onlyoffice;
in
{
  options.bery.apps.onlyoffice = {
    enable = lib.mkEnableOption "onlyoffice";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      onlyoffice-desktopeditors
    ];
  };
}
