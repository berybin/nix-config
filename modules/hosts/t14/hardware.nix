{
  flake.modules.nixos.t14 = {
    hardware.facter.reportPath = ./t14.facter.json;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/8f7709ec-9b06-4983-9f6a-1752f6898cda";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/41C8-7883";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [
      { device = "/dev/disk/by-uuid/392d05c2-06fe-4f7f-86d1-3e4377f8539f"; }
    ];
  };
}
