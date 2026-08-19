{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.tealdeer;
in
{
  options.bery.tools.tealdeer = {
    enable = mkEnableOption "tealdeer - a tldr client implemented in Rust";
  };

  config = mkIf cfg.enable {
    programs.tealdeer.enable = true;
    programs.tealdeer.enableAutoUpdates = true;
    programs.tealdeer.settings.updates.auto_update = true;
  };
}
