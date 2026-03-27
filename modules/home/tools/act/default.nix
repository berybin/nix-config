{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.act;
in
{
  options.bery.tools.act = {
    enable = mkEnableOption "run github actions locally";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      act
    ];
  };
}
