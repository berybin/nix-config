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

      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
          SuspectedFingerprinting = true;
        };
        SanitizeOnShutdown = {
          FormData = true;
          Cache = true;
        };
      };

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
        pins = {
          # NOTE: essential pins
          "codeberg" = {
            id = "740bea3c-861c-4e4e-8c25-e3989bf2c620";
            workspace = spaces.personal.id;
            url = "https://codeberg.org/berybin";
            isEssential = true;
            position = 0;
          };
          "github" = {
            id = "526ab33d-df24-43a5-ad07-af636af4b0e6";
            workspace = spaces.personal.id;
            url = "https://github.com/berybin?tab=repositories";
            isEssential = true;
            position = 1;
          };
          "proton mail" = {
            id = "";
            workspace = spaces.personal.id;
            url = "https://mail.proton.me/u/3/inbox";
            isEssential = true;
            position = 2;
          };
          "proton calendar" = {
            id = "111464c7-4c53-4650-a50c-afd1c9e8daab";
            workspace = spaces.personal.id;
            url = "https://calendar.proton.me/u/3/";
            isEssential = true;
            position = 3;
          };
          "proton drive" = {
            id = "d9803272-b4d3-4203-b7fb-c47239cdb2d4";
            workspace = spaces.personal.id;
            url = "https://drive.proton.me/u/3/";
            isEssential = true;
            position = 4;
          };

          # NOTE: regular pins
          "youtube" = {
            id = "0de4625b-4509-440f-831d-38cf815bf4f9";
            workspace = spaces.personal.id;
            url = "https://www.youtube.com/feed/subscriptions";
            position = 5;
          };

          # NOTE: /nix pin group
          "nix" = {
            id = "75d80b05-c3f4-460d-8064-ea1bcc2ed05c";
            workspace = spaces.personal.id;
            editedTitle = true;
            isGroup = true;
            position = 100;
          };
          "nixos search" = {
            id = "a0770f40-6f7d-4bda-8374-2cf08e23d51e";
            workspace = spaces.personal.id;
            url = "https://search.nixos.org/packages?channel=unstable&include_modular_service_options=1&include_nixos_options=1";
            folderParentId = pins.nix.id;
            position = 102;
          };
        };
      };
    };
  };

}
