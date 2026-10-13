{
  flake.modules.homeManager.vintagestory =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        (vintagestory.override {
          waylandSupport = true;
          wayland = pkgs.wayland;
          x11Support = false;
        })
      ];
    };
}
