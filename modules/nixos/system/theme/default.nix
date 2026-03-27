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
      default = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = cfg.scheme;
      image = cfg.wallpaper;

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.fira-mono;
          name = "FiraMono Nerd Font";
        };
      };

      targets.grub.enable = true;
      targets.console.enable = true;
    };
  };
}
