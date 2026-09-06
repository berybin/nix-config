{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.direnv;
in
{
  options.bery.tools.direnv = {
    enable = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
