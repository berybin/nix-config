{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.services.avahi;
in
{
  options.bery.services.avahi = {
    enable = mkEnableOption "avahi mDNS";
    publish = mkEnableOption "publishing device info to network";
  };

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;

      publish.enable = cfg.publish;
      publish.addresses = cfg.publish;
      publish.workstation = cfg.publish;
    };
  };
}
