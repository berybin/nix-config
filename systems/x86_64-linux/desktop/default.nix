{
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./users.nix
  ];

  system.stateVersion = "25.05";
  networking.hostName = "desktop";

  bery = {
    desktop.plasma.enable = true;

    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      nvidia.enable = true;
    };

    system = {
      boot.enable = true;
      theme.enable = true;
    };

    tools = {
      fish.enable = true;
      docker.enable = true;
      yubikey.enable = true;
      binfmt.enable = true;
      nfs.enable = true;
    };
  };
}
