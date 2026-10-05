{ self, inputs, ... }:
{
  flake.diskoConfigurations.x1 = { lib, config, ... }: {
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
                settings = {
                  # keyFile = "/key/x1-unlock.key";
                  allowDiscards = true;
                  # fallbackToPassword = true;
                  # preLVM = false; # If this is true the decryption is attempted before the postDeviceCommands can run
                };
                passwordFile = "/tmp/password.key";
                additionalKeyFiles = [
                  "/tmp/usb.key"
                ];
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
    # boot.initrd.kernelModules = [
    #   "uas"
    #   "usbcore"
    #   "usb_storage"
    #   "vfat"
    #   "nls_cp437"
    #   "nls_iso8859_1"
    # ];

    # # Mount USB key before trying to decrypt root filesystem
    # boot.initrd.postDeviceCommands = lib.mkBefore ''
    #   mkdir -m 0755 -p /key
    #   sleep 2 # To make sure the USB key has been loaded
    #   mount -n -t vfat -o ro /dev/disk/by-label/KEYS /key
    # '';
  };

  flake.modules.nixos.x1.imports = [
    self.diskoConfigurations.x1
  ];
}
