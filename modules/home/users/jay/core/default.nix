{
  lib,
  config,
  ...
}:
let
  cfg = config.bery.users.jay.core;
in
{
  options.bery.users.jay.core = {
    enable = lib.mkEnableOption "core modules for user jay across all hosts";
  };

  config = lib.mkIf cfg.enable {
    bery.users.jay.theme.enable = lib.mkDefault true;

    bery.tools = {
      nh.enable = true;
      direnv.enable = true;
      nfs.enable = true;
      neovim = {
        enable = true;
        luaPath = "${config.home.homeDirectory}/nix-config/modules/home/tools/neovim/lua";
      };
    };
  };
}
