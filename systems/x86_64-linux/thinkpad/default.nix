{
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./users.nix
  ];

  bery = {
    desktop.plasma.enable = true;

    hardware = {
      bluetooth.enable = true;
      audio.enable = true;
    };

    system = {
      boot.enable = true;
      battery.enable = true;
      theme.enable = true;
    };

    services.ssh.enable = true;
    services.avahi = {
      enable = true;
      publish = true;
    };

    tools = {
      fish.enable = true;
      yubikey.enable = true;
      nfs.enable = true;
    };
  };

  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [
    "root"
    "jay"
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "thinkpad";
  system.stateVersion = "23.11";
}
