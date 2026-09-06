{ inputs, ... }:
{
  flake.modules.nixos.stylix = { pkgs, ... }: {
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

      icons = {
        enable = true;
        package = pkgs.papirus-icon-theme.override { color = "deeporange"; };
        dark = "Papirus-Dark";
        light = "Papirus-Light";
      };

    };
  };

  flake.modules.homeManager.stylix = {
    stylix.targets = {
      neovim.enable = false;
      noctalia.enable = false;
      starship.enable = false;
      vscodium.enable = false;
      zen-browser.enable = false;
    };
  };
}
