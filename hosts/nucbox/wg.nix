{
  flake.modules.nixos.nucbox = { config, ... }: {
    sops.secrets."wg/privatekey" = { };

    networking.wg-quick.interfaces.wg0 = {
      address = [ "${config.berynet.wireguard.nucbox.ip}/32" ];
      privateKeyFile = config.sops.secrets."wg/privatekey".path;

      peers = [
        {
          inherit (config.berynet.wireguard.droplet) publicKey;
          allowedIPs = [ "${config.berynet.wireguard.droplet.ip}/32" ];
          endpoint = "vs.berybin.dev:51820";
          persistentKeepalive = 25; # keep the NAT mapping alive
        }
      ];
    };
  };
}
