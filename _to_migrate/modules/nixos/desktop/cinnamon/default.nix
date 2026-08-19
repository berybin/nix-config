{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.desktop.cinnamon;
  catppuccin-folders = pkgs.catppuccin-papirus-folders.override {
    flavor = "mocha";
    accent = "red";
  };

in
{
  options.bery.desktop.cinnamon = {
    enable = mkEnableOption "Cinnamon desktop";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Enable the Cinnamon Desktop Environment.
      displayManager.lightdm.enable = true;
      desktopManager.cinnamon.enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "au";
        variant = "";
      };

    };

    environment.cinnamon.excludePackages = with pkgs; [
      xterm

      nixos-artwork.wallpapers.simple-dark-gray
      mint-artwork
      mint-cursor-themes
      mint-l-icons
      mint-l-theme
      mint-themes
      mint-x-icons
      mint-y-icons

      gnome-terminal
      xreader
      xviewer
    ];

    environment.systemPackages = [
      catppuccin-folders
    ];
  };
}
