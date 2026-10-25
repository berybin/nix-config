{ modulesPath, ... }: {
  imports = [
    ../core.nix
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  isoImage.edition = "BeryGraphical";

  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager.enable = true;
  services.displayManager.autoLogin.user = "nixos";
}
