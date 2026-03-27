{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.server.pi.core;
in
{
  options.bery.server.pi.core = {
    enable = lib.mkEnableOption "pi core modules (system)";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub.enable = false;
    boot.loader.generic-extlinux-compatible.enable = true;
    hardware.enableRedistributableFirmware = true;

    # zramSwap.enable = true;
    services.journald.storage = "volatile";

    # kill bluetooth
    hardware.bluetooth.enable = false;
    boot.blacklistedKernelModules = [
      "bluetooth"
      "btbcm"
      "hci_uart"
    ];
  };
}
