{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.bery.apps.browsers.hm-zen;
in
{

  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  options.bery.apps.browsers.hm-zen = {
    enable = lib.mkEnableOption "zen browser";
  };

  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      policies = import ./policies.nix;

      profiles.${config.home.username} = rec {
        id = 0; # Profile IDs must be sequential starting from 0
        settings = {
          "zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url" = true;
          "zen.tabs.vertical.right-side" = true;
          "zen.view.compact.enable-at-startup" = true;
          "zen.view.compact.hide-toolbar" = true;
          "zen.view.compact.toolbar-flash-popup" = true;
          "zen.view.use-single-toolbar" = false;
          "zen.welcome-screen.seen" = true;
          "zen.workspaces.separate-essentials" = false;
        };
        keyboardShortcutsVersion = 17; # pin to detect regressions

        spacesForce = true;
        spaces = {
          "personal" = {
            id = "260c5608-43a4-4c86-adfb-8aca1a04aa28";
            icon = "🏡";
            position = 1000;
          };

          "uni" = {
            id = "4e91323f-cfa9-4976-a869-b450d4f04554";
            icon = "🎓";
            position = 2000;
          };
        };

        pinsForce = true;
        pins = import ./pins.nix { inherit spaces inputs; };
      };
    };
  };

}
