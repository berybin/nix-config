{ inputs, ... }:
{
  users.users.jay = {
    isNormalUser = true;
    description = "jay";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    openssh.authorizedKeys.keys = [
      inputs.nix-secrets.jay.ssh.keys.yubikey.public
    ];
  };
}
