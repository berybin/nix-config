{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.bery.apps.zen;
  firefox-addons = pkgs.nur.repos.rycee.firefox-addons;
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  options.bery.apps.zen = {
    enable = lib.mkEnableOption "Zen Browser";
  };

  config = lib.mkIf cfg.enable {

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
      policies = import ./policies.nix;

      profiles.bery = {
        isDefault = true;
        spacesForce = true;
        pinsForce = true;

        spaces = import ./spaces.nix;
        settings = import ./settings.nix;
        pins = import ./essentials.nix;

        presets.betterfox.enable = true;
        presets.catppuccin = {
          enable = true;
          flavor = "Mocha"; # Frappe | Latte | Macchiato | Mocha
          accent = "Red";
        };

        mods = [
          "f7c71d9a-bce2-420f-ae44-a64bd92975ab" # Better Unloaded Tabs - https://zen-browser.app/mods/f7c71d9a-bce2-420f-ae44-a64bd92975ab/
          "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find Bar - https://zen-browser.app/mods/a6335949-4465-4b71-926c-4a52d34bc9c0/
          "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History - https://zen-browser.app/mods/253a3a74-0cc4-47b7-8b82-996a64f030d5/
        ];

        extensions = {
          packages = with firefox-addons; [
            clearurls
            cookie-editor
            floccus
            kagi-search
            privacy-badger
            proton-pass
            return-youtube-dislikes
            sponsorblock
            ublock-origin
            wappalyzer
          ];
        };
      };

    };
  };
}
