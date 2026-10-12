{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}:
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

  users.users.root.openssh.authorizedKeys.keys = lib.attrValues config.berynet.keys;
  services.openssh.enable = lib.mkDefault true;
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
    mkberyusb
    nixos-facter
    smartmontools
    usbutils
    vim
    wget
  ];
}
