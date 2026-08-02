{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  inputs,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.system.theme;
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  options.bery.system.theme = {
    enable = mkEnableOption "system-wide theming with stylix";

    wallpaper = lib.mkOption {
      type = lib.types.path;
      default = ../../../../images/turtle-wp.png;
    };

    scheme = lib.mkOption {
      type = lib.types.str;
      default = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      polarity = "dark";
      base16Scheme = cfg.scheme;

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.fira-mono;
          name = "FiraMono Nerd Font";
        };

        sizes = {
          terminal = 11;
        };
      };

      targets.nixos-icons.enable = false;
    };
  };
}
