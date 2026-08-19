{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.scc;
in
{
  options.bery.tools.scc = {
    enable = mkEnableOption "scc - code counter written in Go";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      scc
    ];
  };
}
