{ inputs, ... }: {
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.disko.flakeModules.disko # Declarative disk partitioning and formatting - https://github.com/nix-community/disko
  ];

  # set flake.systems
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
}
