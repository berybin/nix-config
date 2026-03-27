{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.suites.dev;
in
{
  options.bery.suites.dev = {
    enable = mkEnableOption "dev packages";
  };

  config = mkIf cfg.enable {

    bery.apps = {
      vscode.enable = lib.mkDefault true;
      dbeaver.enable = lib.mkDefault true;
      bruno.enable = lib.mkDefault true;
    };

    bery.tools = {
      git.enable = lib.mkDefault true;
      lazygit.enable = lib.mkDefault true;
      nmap.enable = lib.mkDefault true;
      nil.enable = lib.mkDefault true;
      nixfmt.enable = lib.mkDefault true;
      shellcheck.enable = lib.mkDefault true;
      shfmt.enable = lib.mkDefault true;
    };

  };
}
