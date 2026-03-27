{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.nfs;
in
{
  options.bery.tools.nfs = {
    enable = mkEnableOption "nfs";
  };

  config = mkIf cfg.enable {
    boot.supportedFilesystems = [ "nfs" ];
  };
}
