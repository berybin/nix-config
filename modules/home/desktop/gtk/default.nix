{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.desktop.gtk;
in
{
  options.bery.desktop.gtk = {
    enable = mkEnableOption "gtk theming";
  };

  config = mkIf cfg.enable {

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Colloid-Red-Dark-Catppuccin";
        package = pkgs.colloid-gtk-theme.override {
          themeVariants = [ "red" ];
          colorVariants = [ "dark" ];
          tweaks = [ "catppuccin" ];
        };
      };
    };
  };
}
