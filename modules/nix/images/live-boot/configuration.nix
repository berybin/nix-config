{ self, ... }: {
  flake.modules.nixos.live-boot =
    {
      pkgs,
      modulesPath,
      ...
    }:
    {

      imports = [
        "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
        self.modules.nixos.image-core
      ];

      environment.systemPackages = with pkgs; [
        mkberyusb
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
