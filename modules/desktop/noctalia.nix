{ inputs, ... }: {
  flake.modules.nixos.noctalia = { pkgs, ... }: {
    imports = [
      inputs.noctalia.nixosModules.default
      inputs.noctalia-greeter.nixosModules.default
    ];

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true; # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
      systemd.enable = false;
    };

    programs.noctalia-greeter = {
      enable = true;
      # Optional configuration
      greeter-args = "";
      # Full declarative greeter.toml (overwritten on each activation).
      # See examples/greeter.toml for every key (appearance.palette, output, …).
      settings = {
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 24;
          path = "${pkgs.bibata-cursors}/share/icons";
        };
        keyboard = {
          layout = "us";
        };
      };
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
