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
          programs.niri.settings.outputs."eDP-1" = {
            scale = 1;
          };

          programs.noctalia.settings.idle.behavior.suspend = {
            enable = true;
            action = "lock_and_suspend";
            timeout = 60 * 15;
          };
        }
      ];
    };
    system.stateVersion = "26.05";
  };
}
