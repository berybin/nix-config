{ inputs, ... }: {
  flake.modules.nixos.noctalia = {
    imports = [ inputs.noctalia.nixosModules.default ];

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true; # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
      systemd.enable = false;
    };
  };

  flake.modules.homeManager.noctalia = {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;

      settings = {
        shell.telemetry_enabled = true;

        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Dracula";
        };

        bar.default = {
          margin_ends = 0;
          widget_spacing = 12;
        };

        widget.clock.format = "{:%a | %d %b | %r}";

      };
    };
  };
}
