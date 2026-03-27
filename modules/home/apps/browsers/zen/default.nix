{
  lib,
  inputs, # You also have access to your flake's inputs.
  system, # The system architecture for this host (eg. `x86_64-linux`).
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.apps.browsers.zen;
in
{
  options.bery.apps.browsers.zen = {
    enable = mkEnableOption "zen - a privacy focused browser based on firefox";
  };

  config = mkIf cfg.enable {
    home.packages = [
      inputs.zen-browser.packages."${system}".default
    ];
  };
}
