{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.vscode;
in
{
  options.bery.apps.vscode = {
    enable = mkEnableOption "VSCode";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      vscode
    ];
  };
}
