{
  flake.modules.nixos.nix-droplet = {
    hardware.facter.reportPath = ./droplet.facter.json;

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 20;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
