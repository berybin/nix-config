{
  flake.modules.homeManager.tinkering = { pkgs, ... }: {
    home.packages = with pkgs; [
      freecad
      kicad
      orca-slicer
    ];
  };
}
