{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.desktop.plasma;
in
{
  options.bery.desktop.plasma = {
    enable = lib.mkEnableOption "plasma6 desktop";
  };

  config = lib.mkIf cfg.enable {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
      displayManager.sddm.wayland.enable = true;
    };

    environment.plasma6.excludePackages =
      with pkgs;
      with pkgs.kdePackages;
      [
        elisa
        konsole
      ];
  };
}
