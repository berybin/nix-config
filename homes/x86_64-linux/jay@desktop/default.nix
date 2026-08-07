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
      zen.enable = true;
      vscodium.enable = true;

      orca.enable = true;
      freecad.enable = true;
      okular.enable = true;
      handbrake.enable = true;
      reaper.enable = true;
      kdenlive.enable = true;
      pix.enable = true;
      gnome-disk-utility.enable = true;

      blanket.enable = true;
      krita.enable = true;

      vintagestory.enable = true;
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
      vicinae.enable = true;
      wl-clipboard.enable = true;
    };
  };

  stylix.targets = {
    qt.enable = false;
    kde.enable = false;
    starship.enable = false;
    neovim.enable = false;
    zen-browser.enable = false;
  };
  systemd.user.startServices = "sd-switch"; # Nicely reload system units when changing configs
}
