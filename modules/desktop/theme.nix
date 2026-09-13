{ inputs, ... }:
{
  flake.modules.nixos.theme = { pkgs, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];

    stylix = {
      enable = true;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

      cursor = {
        name = "Bibata-Modern-Ice";
        size = 20;
        package = pkgs.bibata-cursors;
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.fira-mono;
          name = "FiraMono Nerd Font";
        };

        sizes = {
          terminal = 11;
        };
      };
    };
  };

  flake.modules.homeManager.theme = { pkgs, ... }: {
    gtk = {
      enable = true;
      iconTheme = {
        # name = "Papirus-Dark";
        # package = pkgs.papirus-icon-theme.override { color = "deeporange"; };
        name = "Dracula";
        package = pkgs.dracula-icon-theme;
      };

      theme = {
        name = "Dracula";
        package = pkgs.dracula-theme;
      };
    };

    stylix.targets = {
      gtk.enable = false;
      neovim.enable = false;
      noctalia.enable = false;
      starship.enable = false;
      vscodium.enable = false;
      zen-browser.enable = false;
    };
  };
}
