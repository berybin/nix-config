{ inputs, ... }: {
  flake.modules.nixos.impermanence = { lib, config, ... }: {
    imports = [ inputs.impermanence.nixosModules.impermanence ];

    # SOPS needs persisted host key during early activation, before /etc is restored.
    # sops.age.sshKeyPaths = lib.mkDefault [ "/persist/etc/ssh/ssh_host_ed25519_key" ];

    services.openssh.hostKeys = lib.mkForce [
      {
        path = "/persist/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/persist/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
        bits = 4096;
      }
    ];

    boot.initrd.systemd.services.rollback = {
      description = "Rollback BTRFS root subvolume to a clean state";
      wantedBy = [ "initrd.target" ];
      after = [ "systemd-cryptsetup@cryptroot.service" ];
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig = {
        Type = "oneshot";
        UMask = "0077";
      };
      script = builtins.readFile ./rollback.sh;
    };

    assertions = [
      {
        assertion = config.fileSystems."/persist".fsType or null == "btrfs";
        message = "Impermanence requires /persist to be mounted as btrfs";
      }
      {
        assertion = builtins.any (fs: fs.mountPoint == "/" && fs.fsType == "btrfs") (
          builtins.attrValues config.fileSystems
        );
        message = "Impermanence requires root filesystem to be btrfs";
      }
    ];

    fileSystems."/".neededForBoot = true;
    fileSystems."/persist".neededForBoot = true;

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/etc/NetworkManager/system-connections"
        "/var/lib/bluetooth"
        "/var/lib/dbus"
        "/var/lib/NetworkManager"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/var/log"
      ];

      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };
  };
}
