{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.apps.reaper;
in
{
  options.bery.apps.reaper = {
    enable = lib.mkEnableOption "reaper daw";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      reaper
    ];
  };
}
