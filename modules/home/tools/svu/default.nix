{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.svu;
in
{
  options.bery.tools.svu = {
    enable = mkEnableOption "semantic version util";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      svu
    ];
  };
}
