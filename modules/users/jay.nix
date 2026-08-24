{
  lib,
  self,
  ...
}:
let
  username = "jay";
in
{
  flake.modules.nixos.${username} = {
    users.users.${username} = {
      isNormalUser = true;
      description = "Jay";
      extraGroups = [
        "networkmanager"
        "wheel"
        "dialout"
      ];
    };
  };

  flake.modules.homeManager.${username} = {
    imports = with self.modules.homeManager; [
      cli
      nvim
      zen
    ];

    programs.home-manager.enable = true;
    home = {
      inherit username;
      homeDirectory = lib.mkDefault "/home/${username}";
      stateVersion = "25.05";
    };
  };
}
