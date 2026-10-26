{ self, inputs, ... }:
{
  flake.diskoConfigurations.droplet = {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices = {
      disk.main = {
        device = "/dev/vda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # for grub MBR
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
                    swap.swapfile.size = "2G";
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

  flake.modules.nixos.droplet.imports = [
    self.diskoConfigurations.droplet
  ];
}
