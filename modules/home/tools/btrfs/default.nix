{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.btrfs-utilities;
in
{
  options.bery.tools.btrfs-utilities = {
    enable = mkEnableOption "btrfs-utilities";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      btrfs-progs
    ];
  };
}
