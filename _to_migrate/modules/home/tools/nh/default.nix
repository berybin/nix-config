{
  lib,
  config,
  ...
}:
let
  cfg = config.bery.tools.nh;
in
{
  options.bery.tools.nh = {
    enable = lib.mkEnableOption "nix helper";
    flakePath = lib.mkOption {
      type = lib.types.path;
      default = "/home/jay/nix-config";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = cfg.flakePath;
    };
  };
}
