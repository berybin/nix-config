{
  flake.modules.homeManager.media = { pkgs, ... }: {
    home.packages = with pkgs; [
      digikam
      kdePackages.kdenlive
      vlc
    ];
  };
}
