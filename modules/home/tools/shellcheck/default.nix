{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.tools.shellcheck;
in
{
  options.bery.tools.shellcheck = {
    enable = lib.mkEnableOption "shellcheck";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      shellcheck
    ];
  };
}
