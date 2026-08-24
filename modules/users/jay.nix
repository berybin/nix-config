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

  flake.modules.homeManager.${username} = { pkgs, ... }: {
    imports = with self.modules.homeManager; [
      cli
      git
      nvim
      proton
      zen
    ];

    home.packages = with pkgs; [
      gopass
    ];

    programs.home-manager.enable = true;
    home = {
      inherit username;
      homeDirectory = lib.mkDefault "/home/${username}";
      stateVersion = "25.05";
    };
  };
}
