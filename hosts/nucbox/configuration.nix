{
  self,
  ...
}:
{
  flake.modules.nixos.nucbox = {
    imports = with self.modules.nixos; [
      # (self.factory.sops { secretsFile = ./secrets.yaml; })
      system-server
      impermanence
      bery

      vintagestory-server
    ];

    services.vintagestory-server = {
      enable = true;
      openFirewall = true;
      serverConfig = {
        ServerName = "Bery's Story [nucbox]";
        WelcomeMessage = "Welcome {0}, don't freakin die pls";
      };
      mods = [
        # {
        #   download-id = 123882;
        #   filename = "BetterRuinsv0.6.4.zip";
        #   hash = "sha256-xxpMfQCC0ZjOZzoFh73ZcipK0pEYccrZ8GnLyjXiixg=";
        # }
      ];
    };

    security.sudo.wheelNeedsPassword = false;
    nix.settings.trusted-users = [ "bery" ];

    system.stateVersion = "26.11";
  };
}
