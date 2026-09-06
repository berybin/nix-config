{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.yubico-auth;
in
{
  options.bery.apps.yubico-auth = {
    enable = mkEnableOption "yubico authenticator";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      yubioath-flutter
    ];
  };
}
