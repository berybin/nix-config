let
  username = "bery";
  description = "Homelab (berynet) admin account.";
in
{
  flake.modules.nixos.${username} = { lib, config, ... }: {
    users.users.${username} = {
      inherit description;
      isNormalUser = true;
      initialHashedPassword = "";
      extraGroups = [
        "wheel"
      ];

      openssh.authorizedKeys.keys = lib.attrValues config.berynet.keys;
    };
  };
}
