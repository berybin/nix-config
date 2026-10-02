{ self, ... }: {
  flake.modules.nixos.bootstrap-minimal-xfce =
    {
      lib,
      config,
      modulesPath,
      ...
    }:
    {

      imports = [
        self.modules.nixos.bootstrap-core
        "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
      ];

      services.xserver = {
        desktopManager.xfce.enable = true;
        displayManager.lightdm.enable = true;
      };

      services.displayManager.defaultSession = "xfce";
      services.displayManager.autoLogin.user = "nixos";

    };
}
