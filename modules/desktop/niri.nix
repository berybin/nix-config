{
  self,
  inputs,
  config,
  ...
}:
{
  flake.modules.nixos.niri = {
    imports = [ inputs.niri.nixosModules.niri ];
    programs.niri.enable = true;
  };

  flake.modules.homeManager.niri = {
    # niri-flake auto-magically imports the home-manager module
    programs.niri.settings = {
      includes = [
        "${self}/modules/desktop/niri.default.kdl"
      ];
    };
  };
}
