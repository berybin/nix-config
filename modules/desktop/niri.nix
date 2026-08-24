{
  lib,
  self,
  inputs,
  ...
}:
{
  flake.modules.nixos.niri = { pkgs, ... }: {
    imports = [ inputs.niri.nixosModules.niri ];
    programs.niri.enable = true;

    environment.systemPackages = [
      pkgs.wl-clipboard
    ];
  };

  flake.modules.homeManager.niri = { pkgs, config, ... }: {
    # niri-flake auto-magically imports the home-manager module
    programs.niri.settings = {
      includes = [
        "${self}/modules/desktop/niri.default.kdl"
      ];

      spawn-at-startup = [
        { command = [ (lib.getExe pkgs.proton-vpn) ]; }
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
