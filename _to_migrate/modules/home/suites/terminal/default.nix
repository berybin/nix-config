{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.suites.terminal;
in
{
  options.bery.suites.terminal = {
    enable = mkEnableOption "all my interactive terminal tools";
  };

  config = mkIf cfg.enable {
    bery.tools = {
      fish.enable = lib.mkDefault true;
      kitty.enable = lib.mkDefault true;
      starship.enable = lib.mkDefault true;
      zoxide.enable = lib.mkDefault true;

      fastfetch.enable = lib.mkDefault true;
      tealdeer.enable = lib.mkDefault true;
    };
  };
}
