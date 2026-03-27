{
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.raspberry-pi-3

  ];

  bery.server.core.enable = true;
  bery.system.pi.core.enable = true;

  bery.services.adguard.enable = true;
  services.journald.storage = "volatile";

  networking.hostName = "toaster";
  system.stateVersion = "26.05";
}
