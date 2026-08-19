{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.yubikey;
in
{
  options.bery.tools.yubikey = {
    enable = mkEnableOption "utils for yubikey and associated software to work";
  };

  config = mkIf cfg.enable {
    # enable pcscd for yubikey
    services.pcscd.enable = true;

  };
}
