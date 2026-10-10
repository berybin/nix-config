{
  flake.modules.homeManager.tinkering = { pkgs, ... }: {
    home.packages = with pkgs; [
      freecad
      kicad
      mkberyusb
      orca-slicer
      smartmontools
    ];
  };
}
