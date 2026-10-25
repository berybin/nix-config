{ modulesPath, ... }: {
  imports = [
    ../core.nix
    "${modulesPath}/virtualisation/digital-ocean-image.nix"
  ];
}
