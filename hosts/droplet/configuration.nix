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

      system.stateVersion = "26.11";
    };
}
