{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.suites.security;
in
{
  options.bery.suites.security = {
    enable = mkEnableOption "security packages";
  };

  config = mkIf cfg.enable {

    bery.apps = {
      ente.enable = true;
      proton.enable = true;
      yubico-auth.enable = true;
    };

    bery.tools = {
      cryptsetup.enable = true;
      ykman.enable = true;
      gpg.enable = true;
      gopass.enable = true;
    };

    bery.services = {
      gpg-agent.enable = true;
    };
  };
}
