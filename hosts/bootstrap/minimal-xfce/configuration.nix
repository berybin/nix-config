{ self, ... }: {
  flake.modules.nixos.bootstrap-minimal-xfce =
    {
      lib,
      pkgs,
      config,
      modulesPath,
      ...
    }:
    {

      imports = [
        self.modules.nixos.bootstrap-core
        "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
      ];

      image.baseName = lib.mkForce "bootstrap-minimal-xfce-${pkgs.stdenv.hostPlatform.system}";

      services.xserver = {
        enable = true;
        desktopManager.xfce.enable = true;
        displayManager.lightdm.enable = true;
      };

      services.displayManager.defaultSession = "xfce";
      services.displayManager.autoLogin.user = "nixos";
    };
}
