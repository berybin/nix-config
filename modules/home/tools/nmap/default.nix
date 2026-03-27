{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.nmap;
in
{
  options.bery.tools.nmap = {
    enable = mkEnableOption "utility for network discovery and security auditing";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nmap
    ];
  };
}
