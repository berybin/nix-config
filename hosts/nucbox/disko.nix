{ self, inputs, ... }:
{
  flake.diskoConfigurations.nucbox = {
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
            root = {
              size = "100%";
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
                postCreateHook = builtins.readFile ../../scripts/btrfs-impermanence-setup.sh;
              };
            };
          };
        };
      };
    };
  };

  flake.modules.nixos.nucbox.imports = [
    self.diskoConfigurations.nucbox
  ];
}
