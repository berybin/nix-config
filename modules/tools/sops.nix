{ inputs, ... }:
{
  flake.factory.sops = { secretsFile }: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; # use the host SSH key to generate an age key
    sops.defaultSopsFile = secretsFile;
  };
}
