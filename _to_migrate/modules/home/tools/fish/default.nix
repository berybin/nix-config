{
  lib,
  config,
  ...
}:

let
  cfg = config.bery.tools.fish;
in
{
  options.bery.tools.fish = {
    enable = lib.mkEnableOption "fish";
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      shellAbbrs = {

        # git abbreviations
        lg = "lazygit";
        gc = "git commit -m '";
        ga = "git add";
        gaa = "git add .";
        gs = "git status";
        gtn = "git tag $(svn next)"; # tag with next semver tag

        # quickly scan network for hostnames using avahi
        ab = "avahi-browse --all --ignore-local --resolve --terminate";
      };

      shellAliases = {
        ssh = lib.mkIf config.bery.tools.kitty.enable "kitten ssh";
        diff = lib.mkIf config.bery.tools.kitty.enable "kitten diff";
      };

      functions = {
        # overwrite fish_command_not_found - https://github.com/fish-shell/fish-shell/issues/2691
        # solution found copying home-manager example - https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix#L367
        __fish_command_not_found_handler = {
          body = "__fish_default_command_not_found_handler $argv[1]";
          onEvent = "fish_command_not_found";
        };
      };
    };
  };
}
