{
  flake.modules.homeManager.social = { pkgs, ... }: {
    home.packages = with pkgs; [
      discord
    ];
  };
}
