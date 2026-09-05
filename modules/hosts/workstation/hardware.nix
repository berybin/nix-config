{
  flake.modules.nixos.workstation =
    {

      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:

    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      hardware.facter.reportPath = ./workstation.facter.json;

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      boot = {
        initrd.availableKernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "usbhid"
          "sd_mod"
        ];
        initrd.kernelModules = [ ];
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/b903797e-3292-4dba-948c-5830baba3f8b";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/8030-5BBD";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };

        "/mnt/salvage" = {
          device = "/dev/disk/by-uuid/5685d083-3910-408e-9f87-90c611e38217";
          fsType = "ext4";
        };
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/31bd7551-c83a-4ff7-949f-23e6b8874177"; }
      ];

      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
