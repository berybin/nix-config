{
  flake.modules.nixos.x1 = {
    hardware.facter.reportPath = ./x1.facter.json;

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 20;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
