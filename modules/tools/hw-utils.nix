{
  flake.modules.homeManager.hw-utils = { pkgs, ... }: {
    home.packages = with pkgs; [
      gnome-disk-utility
      hardinfo2
    ];
  };
}
