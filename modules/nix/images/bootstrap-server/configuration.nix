{ self, ... }: {
  flake.modules.nixos.bootstrap-server =
    { modulesPath, ... }:
    {
      imports = [
        self.modules.nixos.image-core
        "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
      ];
    };
}
