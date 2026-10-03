{
  flake.modules.nixos.x1 = {
    hardware.facter.reportPath = ./x1.facter.json;
  };
}
