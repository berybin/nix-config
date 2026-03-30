{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.users.jay.theme;
in
{
  options.bery.users.jay.theme = {
    enable = lib.mkEnableOption "home theming w/ stylix";
  };

  config = lib.mkIf cfg.enable {
    # stylix.cursor = {
    #   package = pkgs.bibata-cursors;
    #   name = "Bibata-Modern-Ice";
    #   size = 24;
    # };

    # stylix.polarity = "dark";

    # stylix.icons = {
    #   enable = true;
    #   package = pkgs.catppuccin-papirus-folders.override {
    #     flavor = "mocha";
    #     accent = "red";
    #   };
    #   dark = "Papirus-Dark";
    # };

    # #! ======================================
    # #! ========== DISABLED TARGETS ==========
    # #! ======================================
    # stylix.targets.neovim.enable = false;

    # stylix.targets.waybar.enable = false;
    # stylix.targets.hyprlock.enable = false;
  };
}
