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
        AutofillAddressEnabled = true;
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
      };
    };
  };

}
