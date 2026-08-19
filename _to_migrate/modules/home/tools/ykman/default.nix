{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.ykman;
in
{
  options.bery.tools.ykman = {
    enable = mkEnableOption "cli tool for managing yubikeys";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      yubikey-manager
    ];
  };
}
