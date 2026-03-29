{ config, ... }:

{
  bery.users.jay = {
    core.enable = true;
    optional.plasma.enable = true;
  };

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "jay";
  home.homeDirectory = "/home/jay";
  home.stateVersion = "23.11";

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  bery = {
    suites.common-legacy.enable = true;

    suites.dev.enable = true;
    suites.office.enable = true;
    suites.security.enable = true;
    suites.terminal.enable = true;

    apps = {
      okular.enable = true;
      gnome-disk-utility.enable = true;

      browsers.hm-zen.enable = true;
    };

    tools = {
      btop.enable = true;
    };

  };

  # todo: tidy up this setting
  gtk.gtk4.theme = config.gtk.theme;

  systemd.user.startServices = "sd-switch"; # Nicely reload system units when changing configs
}
