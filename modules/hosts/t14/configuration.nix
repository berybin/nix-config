{ self, config, ... }:
let
  modules = [
    "plasma"
    "nh"
  ];
in
{
  flake.modules.nixos.t14 = {
    imports = with self.modules.nixos; [
      system-desktop
      (self.lib.loadNixosAndHmModulesForUser config modules "jay")
    ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    system.stateVersion = "26.05";
  };
}
