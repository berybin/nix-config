{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.okular;
in
{
  options.bery.apps.okular = {
    enable = mkEnableOption "okular document viewer";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.okular
    ];
  };

}
