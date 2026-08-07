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
        containersForce = true;
        spacesForce = true;
        pinsForce = true;

        containers = import ./containers.nix;
        spaces = import ./spaces.nix;
        pins = import ./essentials.nix;
        settings = import ./settings.nix;

        presets.betterfox.enable = true;
        presets.catppuccin = {
          enable = true;
          flavor = "Mocha"; # Frappe | Latte | Macchiato | Mocha
          accent = "Red";
        };

        mods = [
          "f7c71d9a-bce2-420f-ae44-a64bd92975ab" # Better Unloaded Tabs - https://zen-browser.app/mods/f7c71d9a-bce2-420f-ae44-a64bd92975ab/
        ];

        extensions = {
          packages = with firefox-addons; [
            clearurls
            cookie-editor
            darkreader
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
