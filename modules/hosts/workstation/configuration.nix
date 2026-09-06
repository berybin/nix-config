{ self, config, ... }:
let
  modules = [
    "git"
    "gpg"
    "nh"
    "office"
    "tinkering"
  ];
in
{
  flake.modules.nixos.workstation = {
    imports = with self.modules.nixos; [
      system-desktop
      desktop
      (self.lib.loadNixosAndHmModulesForUser config modules "jay")
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = [
        {
          programs.niri.settings.outputs."ViewSonic Corporation VX3418-2KPC WFJ212700128" = {
            # mode = "3440x1440@144.000";
            mode = {
              width = 3440;
              height = 1440;
              refresh = 144.000;
            };
            scale = 1;
          };
        }
      ];
    };

    system.stateVersion = "25.05";
  };
}
