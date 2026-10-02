let
  username = "bery";
  description = "Homelab (berynet) admin account.";
in
{
  flake.modules.nixos.${username} = {
    users.users.${username} = {
      inherit description;
      isNormalUser = true;
      extraGroups = [
        "wheel"
      ];
    };
  };
}
