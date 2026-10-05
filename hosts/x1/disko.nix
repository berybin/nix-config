{ self, inputs, ... }:
{
  flake.diskoConfigurations.x1 = {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices = {
      disk.main = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                passwordFile = "/tmp/disk-encryption.key";
                additionalKeyFiles = [ "/tmp/usb.key" ];
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "nixos"
                    "-f"
                  ];
                  subvolumes = {
                    "@" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@swap" = {
                      mountpoint = "/.swapvol";
                      mountOptions = [
                        "compress=no"
                        "noatime"
                        # btrfs swapfiles require compression disabled;
                        # explicitly override the inherited compress=zstd from the parent mount
                      ];
                      swap.swapfile.size = "8G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 20;
    boot.loader.efi.canTouchEfiVariables = true;

    # Kernel modules needed for mounting USB VFAT devices in initrd stage
    boot.initrd = {
      luks.devices."cryptroot" = {
        keyFile = "/keys/x1-unlock.key"; # workaround to bootstrap both a password and unattended boot via USB
        keyFileTimeout = 5;
      };

      kernelModules = [
        "uas"
        "usbcore"
        "usb_storage"
        "vfat"
        "nls_cp437"
        "nls_iso8859_1"
      ];

      systemd.mounts = [
        {
          what = "/dev/disk/by-label/KEYS";
          where = "/keys";
          type = "vfat";
          options = "ro,nofail";
          unitConfig = {
            JobRunningTimeoutSec = 5;
          };
        }
      ];
    };

  };

  flake.modules.nixos.x1.imports = [
    self.diskoConfigurations.x1
  ];
}
