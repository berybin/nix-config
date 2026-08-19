{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.goreleaser;
in
{
  options.bery.tools.goreleaser = {
    enable = mkEnableOption "goreleaser";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      goreleaser
    ];
  };
}
