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
    };

    system.stateVersion = "25.05";
  };
}
