{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.tools.ffmpeg;
in
{
  options.bery.tools.ffmpeg = {
    enable = lib.mkEnableOption "ffmpeg";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ffmpeg
    ];
  };
}
