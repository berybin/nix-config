{
  flake.modules.homeManager.user-identity = { lib, config, ... }: {
    options.identity = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Your name. Used for things such as git.";
      };

      email = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
        example = {
          primary = "primary@somedomain.com";
          secondary = "secondary@somedomain.com";
          work = "work@company.com";
        };
      };

      signingKey = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "GPG signing key.";
      };
    };

    config.assertions = [
      {
        assertion = config.identity.email ? primary;
        message = "identity.email: a `primary` address must be defined";
      }
    ];
  };
}
