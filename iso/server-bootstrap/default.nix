{ modulesPath, ... }: {
  imports = [
    ../core.nix
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];
}
