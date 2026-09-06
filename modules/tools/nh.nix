{
  lib,
  config,
  ...
}:
let
  cfg = config.tools.nh;
in
{

  options.tools.nh.flakePath = lib.mkOption {
    type = lib.types.str;
    default = "/home/jay/nix-config";
    description = "Absolute path to the flake directory used by nh.";
  };

  config.flake.modules.nixos.nh = {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 14d --keep 4";
      flake = cfg.flakePath;
    };
  };
}
