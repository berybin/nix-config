{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.tools.wl-clipboard;
in
{
  options.bery.tools.wl-clipboard = {
    enable = lib.mkEnableOption "wl-clipboard";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
    ];
  };
}
