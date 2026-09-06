{
  lib,
  inputs,
  config,
  ...
}:
let
  cfg = config.bery.server.core;
in
{
  options.bery.server.core = {
    enable = lib.mkEnableOption "core server settings";
  };

  config = lib.mkIf cfg.enable {

    users.users.${inputs.nix-secrets.server.core.admin.username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        inputs.nix-secrets.jay.ssh.keys.yubikey.public
      ];
    };

    #! =============================
    #! ========== NETWORK ==========
    #! =============================

    bery.services.ssh.enable = true;

    bery.services.avahi = {
      enable = lib.mkDefault true;
      publish = true;
    };

    #! ====================================
    #! ========== NIX / SECURITY ==========
    #! ====================================

    nix.settings.trusted-users = [
      "root"
      "@wheel"
    ];

    security.sudo.wheelNeedsPassword = lib.mkDefault false;
  };
}
