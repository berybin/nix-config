{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.  config,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.system.ld;
in
{
  options.bery.system.ld = {
    enable = mkEnableOption "nix-ld";
  };

  config = mkIf cfg.enable {
    # https://nix.dev/guides/faq#how-to-run-non-nix-executables
    # Using binary executables downloaded with third-party package managers (e.g. vscode, npm, or pip).
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
    ];
  };
}
