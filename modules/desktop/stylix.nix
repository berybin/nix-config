{ inputs, ... }:
{
  flake.modules.nixos.stylix = { pkgs, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];

    stylix = {
      enable = true;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.fira-mono;
          name = "FiraMono Nerd Font";
        };

        sizes = {
          terminal = 11;
        };
      };

      cursor = {
        name = "Bibata-Modern-Ice";
        size = 18;
        package = pkgs.bibata-cursors;
      };
    };
  };
}
