{ inputs, ... }: {
  flake.modules.nixos.noctalia = { pkgs, ... }: {
    imports = [
      inputs.noctalia.nixosModules.default
      inputs.noctalia-greeter.nixosModules.default
    ];

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true; # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
    };

    # https://wiki.nixos.org/wiki/SDDM#SDDM_Hangs_after_entering_password
    # noctalia-greeter was hanging after password entry. It was ALSO waiting for a fingerprint for 30 seconds
    security.pam.services.login.fprintAuth = false;
    programs.noctalia-greeter = {
      enable = true;
      greeter-args = "";
      settings = {
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 16;
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
      systemd.enable = true;

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
