{
  flake.modules.nixos.nucbox = { config, ... }: {
    sops.secrets."wg/privatekey" = { };

    networking.wg-quick.interfaces.wg0 = {
      address = [ "${config.berynet.wireguard.nucbox.ip}/32" ];
      privateKeyFile = config.sops.secrets."wg/privatekey".path;

      peers = [
        {
          inherit (config.berynet.wireguard.droplet) publicKey;
          endpoint = "${config.berynet.wireguard.server.address}:${toString config.berynet.wireguard.server.port}";
          allowedIPs = [ "${config.berynet.wireguard.droplet.ip}/32" ];
          persistentKeepalive = 25; # keep the NAT mapping alive
        }
      ];
    };
  };
}
