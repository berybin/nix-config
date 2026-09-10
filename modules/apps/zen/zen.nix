{ inputs, ... }: {
  flake.modules.homeManager.zen =
    { pkgs, ... }:
    let
      firefox-addons = pkgs.nur.repos.rycee.firefox-addons;
    in
    {
      imports = [ inputs.zen-browser.homeModules.beta ];

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
        policies = import ./_policies.nix;

        profiles.bery = {
          isDefault = true;
          containersForce = true;
          spacesForce = true;
          pinsForce = true;

          containers = import ./_containers.nix;
          spaces = import ./_spaces.nix;
          pins = import ./_essentials.nix;
          settings = import ./_settings.nix;

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
              sponsorblock
              ublock-origin
              vimium
              wappalyzer
            ];
          };
        };

      };
    };
}
