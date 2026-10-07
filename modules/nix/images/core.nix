{ self, ... }: {
  flake.modules.nixos.image-core =
    {
      lib,
      config,
      ...
    }:
    {
      imports = with self.modules.generic; [
        berynet
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      security.sudo = {
        enable = true;
        wheelNeedsPassword = false;
      };

      users.users.root.openssh.authorizedKeys.keys = lib.attrValues config.berynet.keys;
      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };

      services.avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
          workstation = true;
        };
      };
    };
}
