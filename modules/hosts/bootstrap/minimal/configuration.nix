{ self, modulesPath, ... }: {
  flake.modules.bootstrap.minimal = { lib, config, ... }: {

    imports = [
      self.modules.bootstrap.core
      "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ];
  };
}
