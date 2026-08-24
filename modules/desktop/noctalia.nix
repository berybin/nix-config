{ inputs, ... }: {
  flake.modules.nixos.noctalia = {
    imports = [ inputs.noctalia.nixosModules.default ];

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true; # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
      systemd.enable = true;
    };
  };
}
