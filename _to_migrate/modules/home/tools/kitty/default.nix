{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.kitty;
  fishEnabled = config.bery.tools.fish.enable;
in
{
  options.bery.tools.kitty = {
    enable = mkEnableOption "kitty";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = if fishEnabled then true else false;
    };
  };
}
