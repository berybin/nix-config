{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.services.gpg-agent;
in
{
  options.bery.services.gpg-agent = {
    enable = mkEnableOption "gpg-agent";
    pinentry = mkPackageOption pkgs "pinentry" { default = "pinentry-gnome3"; };
  };

  config = mkIf cfg.enable {
    services.gpg-agent = {
      enable = true;
      pinentry.package = cfg.pinentry;
      enableSshSupport = true;
    };
  };
}
