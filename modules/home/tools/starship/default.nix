{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.starship;
in
{
  options.bery.tools.starship = {
    enable = mkEnableOption "starship";
  };

  config = mkIf cfg.enable {
    # stylix.targets.starship.enable = false;
    xdg.configFile."starship.toml".source = mkForce ./catppuccin.toml;

    programs.starship = {
      enable = true;
      enableTransience = true;
    };
  };
}
