{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.apps.vscodium;
in
{

  options.bery.apps.vscodium = {
    enable = lib.mkEnableOption "VSCodium";
  };

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      ripgrep
    ];

    programs.vscodium = {
      enable = true;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          astro-build.astro-vscode
          mads-hartmann.bash-ide-vscode
        ];
      };
    };

  };
}
