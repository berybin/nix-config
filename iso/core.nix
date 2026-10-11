{ pkgs, modulesPath, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  security.sudo.wheelNeedsPassword = false;

  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";

  services.openssh.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    firefox
    git
    gparted
    htop
    nixos-facter
    smartmontools
    usbutils
    vim
    wget
  ];
}
