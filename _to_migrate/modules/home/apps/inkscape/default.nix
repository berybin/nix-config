{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.apps.inkscape;
in
{
  options.bery.apps.inkscape = {
    enable = lib.mkEnableOption "inkscape";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      inkscape-with-extensions
    ];
  };
}
