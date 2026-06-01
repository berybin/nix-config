{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.tools.vicinae;
in
{
  options.bery.tools.vicinae = {
    enable = lib.mkEnableOption "vicinae launcher";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vicinae
    ];
  };
}
