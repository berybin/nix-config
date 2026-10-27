{
  flake.modules.nixos.droplet = { config, ... }: {
    sops.secrets."wg/privatekey" = { };

    networking.wg-quick.interfaces.wg0 = {
      address = [
        "${config.berynet.wireguard.droplet.ip}/32"
      ];
      listenPort = 51820;
      privateKeyFile = config.sops.secrets."wg/privatekey".path;

      peers = [
        {
          inherit (config.berynet.wireguard.nucbox) publicKey;
          allowedIPs = [
            "${config.berynet.wireguard.nucbox.ip}/32"
          ];
        }
      ];

    };
  };
}
