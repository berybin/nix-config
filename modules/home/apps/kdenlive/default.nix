{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.apps.kdenlive;
in
{
  options.bery.apps.kdenlive = {
    enable = lib.mkEnableOption "kdenlive video editor";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ kdePackages.kdenlive ];
  };
}
