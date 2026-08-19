{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.docker;
in
{
  options.bery.tools.docker = {
    enable = mkEnableOption "docker";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
  };
}
