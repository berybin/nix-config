{ lib, config, ... }: {

  # the `desktop` module is for my preferred desktop environment.
  #
  # It will import all NixOS modules, and will import related
  # home-manager modules if home-manager itself has been imported elsewhere
  flake.modules.nixos.desktop =
    { pkgs, options, ... }:
    let
      desktopModules = [
        "files"
        "niri"
        "noctalia"
        "stylix"
      ];
    in
    {
      imports = builtins.map (module: config.flake.modules.nixos.${module}) desktopModules;

      home-manager.sharedModules = lib.mkIf (options.home-manager ? sharedModules) (
        builtins.map (module: config.flake.modules.homeManager.${module} or { }) desktopModules
      );

      programs.localsend.enable = true;

      environment.systemPackages = with pkgs; [
        qimgv
      ];
    };
}
