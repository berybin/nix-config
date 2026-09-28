{ inputs, ... }:
{
  flake.factory.sops = { secretsFile }: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; # use the host SSH key to generate an age key
    sops.defaultSopsFile = secretsFile;
  };

  flake.modules.homeManager.sops = { secretsFile }: { pkgs, config, ... }: {
    imports = [
      inputs.sops-nix.homeManagerModules.sops
    ];

    home.packages = with pkgs; [ sops ];

    sops.age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    sops.defaultSopsFile = secretsFile;
  };
}
