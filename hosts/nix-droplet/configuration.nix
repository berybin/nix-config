{
  self,
  modulesPath,
  ...
}:
{
  flake.modules.nixos.nix-droplet = {
    imports = with self.modules.nixos; [
      "${modulesPath}/virtualisation/digital-ocean-image.nix"

      system-server
      impermanence
      bery
    ];

    system.stateVersion = "26.11";
  };
}
