{
  flake.modules.nixos.files = { pkgs, ... }: {
    services = {
      gvfs.enable = true;
      tumbler.enable = true;
      dbus.packages = with pkgs; [
        file-roller
        nautilus
      ];
    };

    environment.systemPackages = with pkgs; [
      file-roller
      nautilus
    ];
  };

  flake.modules.homeManager.files = {
    xdg.userDirs.enable = true;
    xdg.userDirs.setSessionVariables = false;
  };
}
