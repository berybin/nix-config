{
  lib,
  config,
  inputs,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.git;
in
{
  options.bery.tools.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        user = {
          name = "jay";
          email = inputs.nix-secrets.jay.email.personal;
        };

        log = {
          showSignature = true;
        };
      };
      signing = {
        format = "openpgp";
        key = "E756A04B17322D8D";
        signByDefault = true;
      };
    };
  };
}
