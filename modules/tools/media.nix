{
  flake.modules.homeManager.media = { pkgs, ... }: {
    home.packages = with pkgs; [
      digikam
      imagemagick
      kdePackages.kdenlive
      vlc
    ];
  };
}
