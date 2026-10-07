{ self, ... }:
{
  flake.modules.nixos.x1 = { lib, config, ... }: {
    imports = [
      self.modules.generic.berynet
    ];

    services.xserver = {
      enable = true;
      desktopManager.xfce.enable = true;
      displayManager.lightdm.enable = true;
    };

    services.displayManager.defaultSession = "xfce";
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

    systemd.sleep.settings.Sleep = {
      AllowHibernation = "no";
    };

    security.sudo.wheelNeedsPassword = false;
    system.stateVersion = "26.11";
  };
}
