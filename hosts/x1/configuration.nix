{ self, inputs, ... }:
{
  flake.modules.nixos.x1 = { lib, config, ... }: {
    imports = [
      self.modules.generic.berynet
      self.modules.nixos.impermanence
      inputs.home-manager.nixosModules.home-manager
    ];
    services.desktopManager.plasma6.enable = true;
    services.displayManager.plasma-login-manager.enable = true;

    services.displayManager.autoLogin.user = "nixos";
    services.getty.autologinUser = "nixos";

    networking.networkmanager.enable = true;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };

    users.users.root.openssh.authorizedKeys.keys = lib.attrValues config.berynet.keys;
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };

    users.users.nixos = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
      ];
      # Allow the graphical user to login without password
      initialHashedPassword = "";
    };

    home-manager.users.nixos.imports = [
      ./_home.nix
    ];

    systemd.sleep.settings.Sleep = {
      AllowHibernation = "no";
    };

    security.sudo.wheelNeedsPassword = false;
    system.stateVersion = "26.11";
  };
}
