{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.nil;
in
{
  options.bery.tools.nil = {
    enable = mkEnableOption "nil language server";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nil
    ];
  };
}
