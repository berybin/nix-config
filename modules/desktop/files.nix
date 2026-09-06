{
  flake.modules.nixos.files =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      cfg = config.tools.files;
    in
    {

      options.tools.files = {
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.nemo-with-extensions;
          description = "The file manager package to use.";
        };

        desktopFile = lib.mkOption {
          type = lib.types.str;
          default = "nemo.desktop";
          description = "The name of the .desktop file for MIME association.";
        };
      };

      config = {
        environment.systemPackages = [
          cfg.package
          pkgs.file-roller
        ];

        services = {
          gvfs.enable = true;
          udisks2.enable = true;
          dbus.packages = [
            cfg.package
            pkgs.file-roller
          ];
        };

        xdg = {
          mime.defaultApplications = {
            "inode/directory" = [ cfg.desktopFile ];
            "application/x-gnome-saved-search" = [ cfg.desktopFile ];
          };
        };
      };
    };
}
