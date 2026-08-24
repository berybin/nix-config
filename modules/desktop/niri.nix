{ inputs, config, ... }: {
  flake.modules.nixos.niri = {
    imports = [ inputs.niri.nixosModules.niri ];
    programs.niri.enable = true;
  };

  flake.modules.homeManager.niri = {
    # niri-flake auto-magically imports the home-manager module
    programs.niri.settings = {
      includes = with config.lib.niri.include; [
        {
          path = ./niri.default.kdl;
        }
      ];
    };
  };
}
