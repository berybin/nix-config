{ inputs, ... }:

{
  flake.modules.nixos.plasma = { pkgs, ... }: {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.plasma-login-manager.enable = true;
    };

    environment.plasma6.excludePackages =
      with pkgs;
      with pkgs.kdePackages;
      [
        elisa
      ];
  };

  flake.modules.homeManager.plasma = { pkgs, ... }: {
    imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

    programs.plasma = {
      enable = true;
      # overrideConfig = true;

      shortcuts = {
        kwin."Window Close" = [
          "Alt+F4"
          "Meta+Q"
        ];
      };

      hotkeys.commands = {
        launch-kitty = {
          name = "Launch Kitty";
          key = "Meta+Return";
          command = "kitty";
        };

        toggle-vicinae = {
          name = "Toggle Vicinae";
          key = "Meta+Space";
          command = "vicinae toggle";
        };
      };

      window-rules = [
        {
          description = "Settings for albert";
          match = {
            window-class = {
              value = "albert";
              type = "substring";
            };

            window-types = [ "utility" ];
          };

          apply = {
            ignoregeometry = {
              value = true;
              apply = "force";
            };

            placement = {
              value = 2;
              apply = "force";
            };
          };
        }
      ];

      kwin = {
        cornerBarrier = false;
      };
    };

    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-qt;
      enableSshSupport = true;
    };
  };
}
