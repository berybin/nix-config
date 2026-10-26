{
  flake.modules.nixos.droplet = { config, ... }: {
    sops.secrets."wg/privatekey" = { };

    networking.wg-quick.interfaces.wg0 = {
      address = config.berynet.wireguard.droplet.address;
      listenPort = 51820;
      privateKeyFile = config.sops.secrets."wg/privatekey".path;

      peers = [

      ];

    };
  };
}
