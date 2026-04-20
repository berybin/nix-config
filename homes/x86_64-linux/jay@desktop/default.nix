{ pkgs, ... }:

{
  bery.users.jay = {
    core.enable = true;
    optional.plasma.enable = true;
  };

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "jay";
  home.homeDirectory = "/home/jay";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  bery = {
    suites.common-legacy.enable = true;

    suites.dev.enable = true;
    suites.office.enable = true;
    suites.security.enable = true;
    suites.terminal.enable = true;

    apps = {
      orca.enable = true;
      blender.enable = true;
      freecad.enable = true;
      okular.enable = true;
      kicad.enable = true;
      handbrake.enable = true;
      reaper.enable = true;
      kdenlive.enable = true;
      pix.enable = true;
      inkscape.enable = true;
      gnome-disk-utility.enable = true;

      browsers.zen.enable = true;
      blanket.enable = true;
      krita.enable = true;
    };

    tools = {
      btop.enable = true;
      ffmpeg.enable = true;
      mod2mp4 = {
        enable = true;
        concurrentConversions = 7;
      };
      colmena.enable = true;
      bottles.enable = true;
    };
  };

  # todo: tidy up this setting
  gtk.gtk4.theme = null; # setting as per eval warning

  systemd.user.startServices = "sd-switch"; # Nicely reload system units when changing configs
}
