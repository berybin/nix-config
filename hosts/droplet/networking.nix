{
  flake.modules.nixos.droplet =
    { config, ... }:
    let
      vintageStoryGamePort = config.berynet.vintagestory.port;
      nucboxIP = config.berynet.wireguard.nucbox.ip;
      dropletIP = config.berynet.wireguard.droplet.ip;
    in
    {
      boot.kernel.sysctl."net.ipv4.ip_forward" = true;

      networking = {
        firewall = {
          allowedTCPPorts = [ vintageStoryGamePort ];
          allowedUDPPorts = [ vintageStoryGamePort ];
        };

        nat = {
          enable = true;
          externalInterface = "ens3";
          internalInterfaces = [ "wg0" ];

          forwardPorts = [
            {
              proto = "tcp";
              sourcePort = vintageStoryGamePort;
              destination = "${nucboxIP}:${toString vintageStoryGamePort}";
            }
            {
              proto = "udp";
              sourcePort = vintageStoryGamePort;
              destination = "${nucboxIP}:${toString vintageStoryGamePort}";
            }
          ];
        };

        nftables = {
          enable = true;
          tables.vintage-story-snat = {
            family = "ip";
            content = ''
              chain postrouting {
                type nat hook postrouting priority srcnat; policy accept;

                oifname "wg0" ip daddr ${nucboxIP} tcp dport ${toString vintageStoryGamePort} snat to ${dropletIP}
                oifname "wg0" ip daddr ${nucboxIP} udp dport ${toString vintageStoryGamePort} snat to ${dropletIP}
              }
            '';
          };
        };
      };
    };
}
