{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.desktop.greetd;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in
{
  options.bery.desktop.greetd = {
    enable = mkEnableOption "greetd";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${tuigreet} --time --remember --asterisks";
          user = "greeter";
        };
      };
    };

    # prevent tuigreet console from getting overwritten systemd startup log
    boot.kernelParams = [ "console=tty1" ];
  };
}
