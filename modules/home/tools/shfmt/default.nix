{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.tools.shfmt;
in
{
  options.bery.tools.shfmt = {
    enable = lib.mkEnableOption "shfmt";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      shfmt
    ];
  };
}
