{ lib, self, ... }:
{
  flake.modules.homeManager = {
    cli = {
      imports = with self.modules.homeManager; [
        fastfetch
        fish
        kitty
        starship
        zoxide
      ];
    };

    fastfetch = {
      programs.fastfetch.enable = true;
    };

    fish = { pkgs, config, ... }: {
      programs.fish = {
        enable = true;
        shellAbbrs = {
          # quickly scan network for hostnames using avahi
          # ab = "avahi-browse --all --ignore-local --resolve --terminate";
        };

        shellAliases = {
          ssh = lib.mkIf config.programs.kitty.enable "kitten ssh";
          diff = lib.mkIf config.programs.kitty.enable "kitten diff";

          # git aliases
          lg = "${lib.getExe pkgs.lazygit}";
          gc = "git commit";
          ga = "git add";
          gaa = "git add .";
          gs = "git status";
          gtn = "git tag $(${lib.getExe pkgs.svu} next)"; # tag with next semver tag
        };

        functions = {
          # overwrite fish_command_not_found - https://github.com/fish-shell/fish-shell/issues/2691
          # solution found copying home-manager example - https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix#L367
          __fish_command_not_found_handler = {
            body = "__fish_default_command_not_found_handler $argv[1]";
            onEvent = "fish_command_not_found";
          };
        };
      };
    };

    kitty =
      { config, ... }:
      let
        fishEnabled = config.programs.fish.enable;
      in
      {
        programs.kitty = {
          enable = true;
          shellIntegration.enableFishIntegration = fishEnabled;
          settings = lib.mkIf fishEnabled {
            shell = "fish";
          };
        };
      };

    starship = { config, ... }: {
      programs.starship = {
        enable = true;
        enableTransience = true;
        enableFishIntegration = config.programs.fish.enable;
        presets = [ "catppuccin-powerline" ];

      };
    };

    zoxide = { config, ... }: {
      programs.zoxide = {
        enable = true;
        enableFishIntegration = config.programs.fish.enable;
      };

      programs.fish.shellAliases = {
        cd = "z";
      };
    };
  };
}
