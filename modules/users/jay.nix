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
      ente-auth
      gopass
      obsidian
    ];

    home = {
      inherit username;
      homeDirectory = lib.mkDefault "/home/${username}";
      stateVersion = "25.05";
      sessionVariables = {
        GOPASS_CLIPBOARD_COPY_CMD = "wl-copy --sensitive";
      };
    };
  };
}
