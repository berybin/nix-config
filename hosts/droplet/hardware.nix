{
  flake.modules.nixos.droplet = { lib, ... }: {
    hardware.facter.reportPath = ./droplet.facter.json;
    boot.loader.grub.enable = true;

    # It seems like digital-ocean-config.nix and disko are both setting `boot.loader.grub.devices`
    # and throwing a "You cannot have duplicated devices in mirroredBoots" error.
    #
    # The below prevents the duplicated device and prevents the error.
    #
    # https://github.com/nix-community/disko/issues/1068#issuecomment-2974926079
    #
    # ========================================================================================================================
    # nix eval --json .#nixosConfigurations.droplet.options.boot.loader.grub.devices.definitionsWithLocations
    # [
    #   {
    #     "file": "/nix/store/adcpmshidndclaz4dxjsgklrx3gqhaxp-source/module.nix",
    #     "value": [
    #       "/dev/vda"
    #     ]
    #   },
    #   {
    #     "file": "/nix/store/2g1ydkkflg5kl8hb1f8js0s0p9v4gl53-source/nixos/modules/virtualisation/digital-ocean-config.nix",
    #     "value": [
    #       "/dev/vda"
    #     ]
    #   }
    # ]

    boot.loader.grub.devices = lib.mkForce [ "/dev/vda" ];
  };
}
