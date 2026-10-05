{ self, ... }: {
  flake.modules.nixos.luddite =
    {
      lib,
      pkgs,
      ...
    }:
    {

      imports = [
        self.modules.nixos.live-boot
        self.packages.${pkgs.stdenv.hostPlatform.system}.mkberyusb
      ];

      isoImage.edition = lib.mkForce "luddite";

      # Disable networking so the system is air-gapped
      # Comment all of these lines out if you'll need internet access
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
    };
}
