{
  self,
  ...
}:
{
  flake.modules.nixos.nucbox = { config, ... }: {
    imports = with self.modules.nixos; [
      (self.factory.sops { secretsFile = ./secrets.yaml; })
      system-server
      impermanence
      bery

      vintagestory-server
    ];

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/lib/vintagestory"
      ];
    };

    services.vintagestory-server = {
      enable = true;
      port = config.berynet.vintagestory.port;
      openFirewall = true;
      serverConfig = {
        ServerName = "Bery's Story [nucbox]";
        WelcomeMessage = "Welcome {0}, don't freakin die pls";
        WhitelistMode = "on";
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
