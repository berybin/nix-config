{
  imports = [ ../core.nix ];

  isoImage.edition = "BeryGraphical";

  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager.enable = true;
  services.displayManager.autoLogin.user = "nixos";
}
