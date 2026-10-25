{ lib, modulesPath, ... }:
{
  imports = [
    ../graphical
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  isoImage.edition = lib.mkForce "luddite";

  # Disable networking so the system is air-gapped
  services.openssh.enable = false;
  boot.initrd.network.enable = false;
  networking = {
    resolvconf.enable = false;
    dhcpcd.enable = false;
    dhcpcd.allowInterfaces = [ ];
    interfaces = { };
    firewall.enable = true;
    useDHCP = false;
    useNetworkd = false;
    wireless.enable = false;
    networkmanager.enable = lib.mkForce false;
  };
}
