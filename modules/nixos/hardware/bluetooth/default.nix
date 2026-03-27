{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.hardware.bluetooth;
in
{
  options.bery.hardware.bluetooth = {
    enable = mkEnableOption "bluetooth";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    # use latest linuxPackages as this fixes
    # weird logitech mx master 3s mouse connectivity issues
    boot.kernelPackages = pkgs.linuxPackages_latest;

  };
}
