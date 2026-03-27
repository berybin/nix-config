{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.cryptsetup;
in
{
  options.bery.tools.cryptsetup = {
    enable = mkEnableOption "cryptsetup";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cryptsetup
    ];
  };
}
