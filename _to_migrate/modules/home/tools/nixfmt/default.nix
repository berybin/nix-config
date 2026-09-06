{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.nixfmt;
in
{
  options.bery.tools.nixfmt = {
    enable = mkEnableOption "nixfmt";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nixfmt
    ];
  };
}
