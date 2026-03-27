{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.asunder;
in
{
  options.bery.apps.asunder = {
    enable = mkEnableOption "cd ripper";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      asunder
    ];
  };
}
