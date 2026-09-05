{
  flake.modules.nixos.office = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      calibre
      kdePackages.okular
      onlyoffice-desktopeditors
    ];
  };
}
