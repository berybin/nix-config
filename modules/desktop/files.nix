{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    services = {
      gvfs.enable = true;
      # allow nautilus to generate image/video thumbnails
      tumbler.enable = true;
      dbus.packages = [
        pkgs.nautilus
      ];
    };

    environment.systemPackages = [
      pkgs.nautilus
    ];
  };
}
