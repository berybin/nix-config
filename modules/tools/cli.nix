{ lib, self, ... }:
{
  flake.modules.nixos.cli = {
    programs.fish.enable = true;
  };

  flake.modules.homeManager = {
    cli = {
      imports = with self.modules.homeManager; [
        btop
        fastfetch
        fish
        kitty
        starship
        zoxide
      ];
    };

    btop = {
      programs.btop.enable = true;
    };

    fastfetch = {
      programs.fastfetch.enable = true;
    };

    fish = { pkgs, config, ... }: {
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
        '';
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
