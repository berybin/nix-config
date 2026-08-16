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
    suites.terminal.enable = true;
    apps.zen.enable = true;

    tools = {
      gpg.enable = true;
      gopass.enable = true;
      git.enable = true;
      lazygit.enable = true;
    };
  };

  systemd.user.startServices = "sd-switch"; # Nicely reload system units when changing configs
}
