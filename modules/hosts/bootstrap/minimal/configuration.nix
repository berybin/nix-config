{ self, ... }: {
  flake.modules.nixos.bootstrap-minimal =
    {
      lib,
      config,
      modulesPath,
      ...
    }:
    {

      imports = [
        self.modules.nixos.bootstrap-core
        "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
      ];
    };
}
