{
  lib,
  config,
  ...
}:
let
  cfg = config.bery.services.jellyfin;
in
{
  options.bery.services.jellyfin = {
    enable = lib.mkEnableOption "jellyfin media server";
    user = lib.mkOption {
      type = lib.types.str;
      default = "media";
      description = "account Jellyfin runs under";
    };
  };

  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      user = cfg.user;

      hardwareAcceleration = {
        enable = true;
        type = "qsv";
        device = "/dev/dri/renderD128";
      };

      openFirewall = true;
    };
  };
}
