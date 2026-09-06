{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.bruno;
in
{
  options.bery.apps.bruno = {
    enable = mkEnableOption "API testing tool like postman";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bruno
    ];
  };
}
