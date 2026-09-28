{ inputs, ... }:
{
  flake.modules.homeManager.sops = { pkgs, config, ... }: {
    imports = [
      inputs.sops-nix.homeManagerModules.sops
    ];

    home.packages = with pkgs; [ sops ];
    sops.age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    sops.defaultSopsFile = ./secrets.yaml;
  };
}
