{
  self,
  ...
}:
{
  flake.modules.nixos.nucbox = {
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

    security.sudo.wheelNeedsPassword = false;
    nix.settings.trusted-users = [ "bery" ];

    system.stateVersion = "26.11";
  };
}
