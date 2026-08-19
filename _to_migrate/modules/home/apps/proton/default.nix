{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.proton;
in
{
  options.bery.apps.proton = {
    enable = mkEnableOption "proton tool suite";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      proton-vpn
      proton-pass
    ];
  };
}
