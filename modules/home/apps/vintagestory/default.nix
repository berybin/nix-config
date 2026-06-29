{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.apps.vintagestory;
in
{
  options.bery.apps.vintagestory = {
    enable = lib.mkEnableOption "vintagestory";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vintagestory
    ];
  };
}
