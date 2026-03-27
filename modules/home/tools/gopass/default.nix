{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.gopass;
in
{
  options.bery.tools.gopass = {
    enable = mkEnableOption "gopass. a pass-like password manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gopass
    ];
  };
}
