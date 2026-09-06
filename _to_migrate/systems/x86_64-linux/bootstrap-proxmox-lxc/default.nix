{
  inputs,
  modulesPath,
  ...
}:
{
  imports = [
    "${modulesPath}/virtualisation/proxmox-lxc.nix"
  ];

  bery.services.avahi = {
    enable = true;
    publish = true;
  };

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    inputs.nix-secrets.jay.ssh.keys.yubikey.public
  ];

  system.stateVersion = "26.05";
}
