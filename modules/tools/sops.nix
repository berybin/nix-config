{ inputs, ... }:
{
  flake.factory.sops =
    { secretsFile }:
    let
      hostKeyPath = "/etc/ssh/ssh_host_ed25519_key";
    in
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      sops = {
        defaultSopsFile = secretsFile;
        environment.SOPS_AGE_SSH_PRIVATE_KEY_FILE = hostKeyPath; # this is a workaround - https://github.com/Mic92/sops-nix/issues/824#issuecomment-3731873228
        # age.sshKeyPaths = [ hostKeyPath ]; # use the host SSH key to generate an age key
      };
    };

  flake.modules.homeManager.sops = { pkgs, ... }: {
    home.packages = with pkgs; [
      # sops
    ];
  };
}
