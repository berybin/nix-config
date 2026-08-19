{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.apps.blanket;
in
{
  options.bery.apps.blanket = {
    enable = lib.mkEnableOption "blanket (ambient sounds)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      blanket
    ];
  };
}
