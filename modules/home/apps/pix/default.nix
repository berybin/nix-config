{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.apps.pix;
in
{
  options.bery.apps.pix = {
    enable = lib.mkEnableOption "pix image viewer";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ pix ];
  };
}
