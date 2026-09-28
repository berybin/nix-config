{ inputs, ... }: {
  flake.modules.homeManager.git = { config, ... }: {
    programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        user = {
          name = config.identity.name;
          email = config.identity.email.primary;
        };

        log = {
          showSignature = true;
        };

        pull.ff = "only";
      };

      # TODO: make this more dynamic
      signing = {
        format = "openpgp";
        key = config.identity.signingKey;
        signByDefault = true;
      };
    };
  };
}
