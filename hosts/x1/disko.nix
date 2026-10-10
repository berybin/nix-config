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
                  keyFileTimeout = 15;
                  crypttabExtraOpts = [
                    "fido2-device=auto"
                    "token-timeout=10"
                  ];
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
                  postCreateHook = ''
                    mount -t btrfs /dev/disk/by-label/nixos /mnt
                    trap 'umount "/mnt"' EXIT

                    # Create the blank snapshot for impermanence rollback
                    btrfs subvolume snapshot -r /mnt/@ /mnt/@blank

                    # Pre-create critical directories in /persist for first boot
                    # This is essential for nixos-anywhere + impermanence to work
                    mkdir -p /mnt/@persist/{root,srv,etc/nixos,etc/ssh}
                    mkdir -p /mnt/@persist/var/{spool,cache,db}
                    mkdir -p /mnt/@persist/var/lib/{nixos,systemd,dbus,bluetooth,NetworkManager}
                    mkdir -p /mnt/@persist/var/lib/systemd/{coredump,timers,timesync}
                    mkdir -p /mnt/@persist/var/db/sudo
                    mkdir -p /mnt/@persist/etc/NetworkManager/system-connections

                    # Set proper permissions
                    chmod 700 /mnt/@persist/root
                    chmod 700 /mnt/@persist/var/db/sudo
                    chmod 700 /mnt/@persist/etc/NetworkManager/system-connections
                  '';
                };
              };
            };
          };
        };
      };
    };

    boot.initrd = {
      luks.devices."cryptroot".keyFile = "/keys/x1-unlock.key"; # workaround to bootstrap both a password and unattended boot via USB

      # Kernel modules needed for mounting USB VFAT devices in initrd stage
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
          unitConfig.JobTimeoutSec = "10s";
          unitConfig.TimeoutSec = "10s";
        }
      ];
    };
  };

  flake.modules.nixos.x1.imports = [
    self.diskoConfigurations.x1
  ];
}
