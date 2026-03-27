{
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    "${modulesPath}/virtualisation/proxmox-lxc.nix"
  ];

  bery.server.core.enable = true;

  users.users = {
    media = {
      isNormalUser = true;
      extraGroups = [
        "video"
        "render"
      ];
    };
  };

  bery.services.jellyfin.enable = true;

  hardware.enableAllFirmware = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
    ];
  };

  networking.wireless.enable = lib.mkForce false;
  system.stateVersion = "26.05";
}
