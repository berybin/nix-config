{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.ente;
in
{
  options.bery.apps.ente = {
    enable = mkEnableOption "ente authenticator";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ente-auth
    ];
  };
}
