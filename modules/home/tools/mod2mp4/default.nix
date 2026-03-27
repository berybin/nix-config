{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.tools.mod2mp4;
in
{
  options.bery.tools.mod2mp4 = {
    enable = lib.mkEnableOption "mod2mp4";
    concurrentConversions = lib.mkOption {
      type = lib.types.int;
      default = 5;
      description = "Number of concurrent files that can be converted.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.bery; [
      (mod2mp4.override {
        concurrentConversions = cfg.concurrentConversions;
      })
    ];
  };
}
