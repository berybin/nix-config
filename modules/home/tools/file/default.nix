{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.file;
in
{
  options.bery.tools.file = {
    enable = mkEnableOption "shows type of file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      file
    ];
  };
}
