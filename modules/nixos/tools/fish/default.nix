{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.fish;
in
{
  options.bery.tools.fish = {
    enable = mkEnableOption "fish shell with interactive shell workaround";
  };

  config = mkIf cfg.enable {
    # Handle shell stuff. Use bash as default, but drop into fish - https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell
    programs.fish.enable = true;
    programs.bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
  };
}
