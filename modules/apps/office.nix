{
  flake.modules.nixos.office = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      calibre
      onlyoffice-desktopeditors
      papers
    ];
  };
}
