{ inputs, ... }: {
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  # set flake.systems
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
}
