{ lib, modulesPath, ... }: {
  imports = [
    ../core.nix
    "${modulesPath}/virtualisation/digital-ocean-image.nix"
  ];

  system.stateVersion = lib.mkDefault lib.trivial.release;
}
