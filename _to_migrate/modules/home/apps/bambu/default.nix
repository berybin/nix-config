{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.bambu;
in
{
  options.bery.apps.bambu = {
    enable = mkEnableOption "bambu";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      bambu-studio
    ];

  };
}
