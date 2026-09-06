{ inputs, modulesPath, ... }:
{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  services.openssh.enable = true;
  users.users.root = {
    openssh.authorizedKeys.keys = [
      inputs.nix-secrets.jay.ssh.keys.yubikey.public
    ];
  };

  bery.services.avahi = {
    enable = true;
    publish = true;
  };

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  hardware.enableRedistributableFirmware = true;
  # boot.kernelParams = [ "console=tty1" ];

  zramSwap.enable = true;
  services.journald.storage = "volatile";

  sdImage.compressImage = true;
  sdImage.extraFirmwareConfig = ''
    dtoverlay=disable-bt
  '';

  networking.hostName = "pi-bootstrap";
  system.stateVersion = "26.05";
}
