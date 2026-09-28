{
  lib,
  self,
  ...
}:
let
  username = "jay";
  signingKey = "E757A04B17322D8D"; # yubikey
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

  flake.modules.homeManager.${username} = { lib, pkgs, ... }: {
    imports = with self.modules.homeManager; [
      user-core

      cli
      git
      gopass
      nvim
      proton
      sops
      zen
    ];

    identity = {
      name = username;
      email.primary = "me@jayparry.dev";
      signingKey = lib.mkDefault signingKey;
    };

    home.packages = with pkgs; [
      ente-auth
      obsidian
    ];

    home = {
      inherit username;
      homeDirectory = lib.mkDefault "/home/${username}";
      stateVersion = "25.05";
    };
  };
}
