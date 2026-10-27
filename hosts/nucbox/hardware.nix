{
  flake.modules.nixos.nucbox = {
    hardware.facter.reportPath = ./nucbox.facter.json;

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 20;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
