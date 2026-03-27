{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.bery.users.jay.optional.plasma;
in
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  options.bery.users.jay.optional.plasma = {
    enable = lib.mkEnableOption "plasma settings";
  };

  config = lib.mkIf cfg.enable {
    programs.plasma = {
      enable = true;
      # overrideConfig = true;

      shortcuts = {
        kwin."Window Close" = [
          "Alt+F4"
          "Meta+Q"
        ];
      };

      krunner = {
        activateWhenTypingOnDesktop = true;
        position = "center";

        shortcuts = {
          launch = "Meta+Space";
        };
      };

      hotkeys.commands = {
        launch-kitty = {
          name = "Launch Kitty";
          key = "Meta+Return";
          command = "kitty";
        };

        # toggle-albert = {
        #   name = "Toggle Albert";
        #   key = "Meta+Space";
        #   command = "albert toggle";
        # };
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

    # set pinentry-qt, lazygit breaks with pinentry-curses
    bery.services.gpg-agent.pinentry = pkgs.pinentry-qt;

    # fix .gtkrc-2.0 clobbering issue
    gtk.gtk2.force = true;
  };
}
