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

  flake.modules.homeManager.niri =
    {
      pkgs,
      config,
      osConfig,
      ...
    }:
    {
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
            "Mod+E".action.spawn = lib.getExe osConfig.tools.files.package;
          }

          (lib.mkIf config.programs.kitty.enable {
            # Only add if kitty is enabled
            "Mod+Return".action.spawn = lib.getExe config.programs.kitty.package;
          })
        ];

        window-rules = [
          {
            matches = [ { app-id = "zen-beta"; } ];
            open-fullscreen = true;
          }

          {
            # GPG key for signing should open focused
            matches = [ { app-id = "gcr-prompter"; } ];
            default-column-width.fixed = 512;
            open-floating = true;
            open-focused = true;
          }
        ];
      };
    };
}
