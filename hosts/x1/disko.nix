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
                settings.allowDiscards = true;
                passwordFile = "/tmp/secret.key";
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
  };

  flake.modules.nixos.x1.imports = [
    self.diskoConfigurations.x1
  ];
}
