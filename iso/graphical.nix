{ lib, ... }:
{
  imports = [
    ./core.nix
  ];

  isoImage.edition = lib.mkDefault "bery-graphical";

  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager.enable = true;
  services.displayManager.autoLogin.user = "nixos";
}
