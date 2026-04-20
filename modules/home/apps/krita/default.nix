{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.apps.krita;
in
{
  options.bery.apps.krita = {
    enable = lib.mkEnableOption "krita (open source painting application)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      krita
    ];
  };
}
