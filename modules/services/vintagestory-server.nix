{
  flake.modules.nixos.vintagestory-server = { lib, ... }: {
    options.services.vintagestory-server = {
      enable = lib.mkEnableOption "Vintage Story Server";

      user = lib.mkOption {
        default = "vintagestory";
        type = lib.types.str;
        description = ''
          User account under which vintagestory-server runs.

          ::: {.note}
          If left as the default value this user will automatically be created
          on system activation, otherwise you are responsible for
          ensuring the user exists before the Vintage Story Server service starts.
          :::
        '';
      };
    };
  };
}
