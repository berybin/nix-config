{
  lib,
  config,
  ...
}:
let
  cfg = config.bery.tools.zoxide;
in
{
  options.bery.tools.zoxide = {
    enable = lib.mkEnableOption "zoxide - a smarter cd command";
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide.enable = true;

    programs.zoxide.enableFishIntegration = config.bery.tools.fish.enable;
    programs.fish.shellAliases = {
      cd = "z";
    };
  };
}
