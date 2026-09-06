{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.bery.tools.colmena;
in
{
  options.bery.tools.colmena = {
    enable = lib.mkEnableOption "colmena";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.colmena.packages."${pkgs.stdenv.hostPlatform.system}".colmena
    ];
  };
}
