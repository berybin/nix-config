{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.services.printing;
in
{
  options.bery.services.printing = {
    enable = mkEnableOption "printing with CUPS service";
  };

  config = mkIf cfg.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
