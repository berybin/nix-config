{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.binfmt;
in
{
  options.bery.tools.binfmt = {
    enable = mkEnableOption "boot.binfmt options";
  };

  config = mkIf cfg.enable {
    boot.binfmt.emulatedSystems = [
      "aarch64-linux"
    ];
  };
}
