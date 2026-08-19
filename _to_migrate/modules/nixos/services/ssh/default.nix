{
  lib,
  config,
  ...
}:
let
  cfg = config.bery.services.ssh;
in
{
  options.bery.services.ssh = {
    enable = lib.mkEnableOption "openssh server";
    hardenedConfig = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether or not to use a hardened config. This will prevent password authentication, etc.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = lib.mkDefault true;
      settings = lib.mkIf cfg.hardenedConfig {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
