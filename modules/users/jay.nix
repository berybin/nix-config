{
  self,
  ...
}:
let
  username = "jay";
  signingKey = "E757A04B17322D8D"; # yubikey
in
{
  flake.modules.nixos.${username} = { config, ... }: {
    imports = [ self.modules.nixos.user-sops ];
    users.mutableUsers = false;
    sops.secrets."passwords/jay".neededForUsers = true;

    users.users.${username} = {
      isNormalUser = true;
      hashedPassword = config.sops.secrets."passwords/jay".path;
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
      user-sops
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
