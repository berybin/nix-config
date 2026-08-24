{
  lib,
  self,
  inputs,
  ...
}:
{
  flake.modules.nixos.niri = {
    imports = [ inputs.niri.nixosModules.niri ];
    programs.niri.enable = true;
  };

  flake.modules.homeManager.niri = { config, ... }: {
    # niri-flake auto-magically imports the home-manager module
    programs.niri.settings = {
      includes = [
        "${self}/modules/desktop/niri.default.kdl"
      ];

      layout = {
        default-column-width.proportion = 0.5;
        center-focused-column = "on-overflow";
      };

      binds = lib.mkMerge [
        {
          # Put normal keyninds here
        }

        (lib.mkIf config.programs.kitty.enable {
          # Only add if kitty is enabled
          "Mod+Return".action.spawn = lib.getExe config.programs.kitty.package;
        })
      ];
    };
  };
}
