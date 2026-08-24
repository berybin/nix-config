{ self, config, ... }:
let
  modules = [
    "git"
    "gpg"
    "nh"
  ];
in
{
  flake.modules.nixos.t14 = {
    imports =
      with self.modules.nixos;
      [
        system-desktop
        desktop
      ]
      ++ [ (self.lib.loadNixosAndHmModulesForUser config modules "jay") ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.sharedModules = [
      {
        programs.niri.settings.outputs."eDP-1" = {
          scale = 1;
        };
      }
    ];
    system.stateVersion = "26.05";
  };
}
