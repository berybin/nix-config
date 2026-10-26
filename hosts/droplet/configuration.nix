{
  self,
  ...
}:
{
  flake.modules.nixos.droplet =
    {
      modulesPath,
      ...
    }:
    {
      imports = with self.modules.nixos; [
        "${modulesPath}/virtualisation/digital-ocean-image.nix"

        system-server
        impermanence
        bery

        (self.factory.sops { secretsFile = ./secrets.yaml; })
      ];

      security.sudo.wheelNeedsPassword = false;
      nix.settings.trusted-users = [ "bery" ];

      system.stateVersion = "26.11";
    };
}
