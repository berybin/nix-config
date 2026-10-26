{
  flake.modules.nixos.droplet = {
    hardware.facter.reportPath = ./droplet.facter.json;
    boot.loader.grub.enable = true;
  };
}
