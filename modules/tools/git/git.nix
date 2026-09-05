{ inputs, ... }: {
  flake.modules.homeManager.git = {
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

      # TODO: make this more dynamic
      signing = {
        format = "openpgp";
        key = "E756A04B17322D8D";
        signByDefault = true;
      };
    };
  };
}
