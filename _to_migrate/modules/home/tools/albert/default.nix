{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.albert;
in
{
  options.bery.tools.albert = {
    enable = mkEnableOption "albert application launcher";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      albert
    ];
  };
}
