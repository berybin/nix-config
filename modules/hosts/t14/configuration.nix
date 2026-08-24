{ self, config, ... }:
let
  modules = [
    "plasma"
  ];
in
{
  flake.modules.nixos.t14 = {
    imports = with self.modules.nixos; [
      system-desktop
      (self.lib.loadNixosAndHmModulesForUser config modules "jay")
    ];
    system.stateVersion = "26.05";
  };
}
