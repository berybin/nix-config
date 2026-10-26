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
      ];

      security.sudo.wheelNeedsPassword = false;
      nix.settings.trusted-users = [ "bery" ];

      system.stateVersion = "26.11";
    };
}
