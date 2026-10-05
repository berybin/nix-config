{ self, ... }: {
  flake.modules.nixos.live-boot =
    {
      modulesPath,
      ...
    }:
    {

      imports = [
        self.modules.nixos.bootstrap-core
        "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
      ];

      isoImage.edition = "live-boot";

      services.xserver = {
        enable = true;
        desktopManager.xfce.enable = true;
        displayManager.lightdm.enable = true;
      };

      services.displayManager.defaultSession = "xfce";
      services.displayManager.autoLogin.user = "nixos";
    };
}
