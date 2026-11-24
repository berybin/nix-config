{
  flake.modules.homeManager.hardinfo = { pkgs, ... }: {
    home.packages = with pkgs; [
      hardinfo2
    ];
  };
}
