{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.tools.bottles;
in
{
  options.bery.tools.bottles = {
    enable = lib.mkEnableOption "bottles";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.bottles
    ];
  };
}
