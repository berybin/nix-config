{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.system.boot;
in
{
  options.bery.system.boot = {
    enable = mkEnableOption "system boot defaults";
  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
