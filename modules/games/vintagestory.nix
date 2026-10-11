{
  flake.modules.homeManager.vintagestory =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        vintagestory
      ];
    };
}
