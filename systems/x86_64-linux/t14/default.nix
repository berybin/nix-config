{
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./users.nix
  ];

  system.stateVersion = "26.05";
  networking.hostName = "t14";

  nix.settings.trusted-users = [
    "@wheel"
  ];

  bery = {
    desktop.plasma.enable = true;

    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
    };

    system = {
      boot.enable = true;
    };

    tools = {
      fish.enable = true;
    };
  };
}
