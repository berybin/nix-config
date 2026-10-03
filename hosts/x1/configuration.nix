{ self, ... }:
{
  flake.modules.nixos.x1 = {
    imports = with self.modules.nixos; [
      system-desktop
    ];

    services.xserver = {
      enable = true;
      desktopManager.xfce.enable = true;
      displayManager.lightdm.enable = true;
    };

    services.displayManager.defaultSession = "xfce";
    services.displayManager.autoLogin.user = "nixos";
    services.getty.autologinUser = "nixos";

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

    security.sudo.wheelNeedsPassword = false;

    system.stateVersion = "26.11";
  };
}
