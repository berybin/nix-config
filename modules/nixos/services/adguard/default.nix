{
  lib,
  config,
  ...
}:
let
  cfg = config.bery.services.adguard;
in
{
  options.bery.services.adguard = {
    enable = lib.mkEnableOption "adguard home service";
  };

  config = lib.mkIf cfg.enable {
    services.adguardhome = {
      enable = true;
      host = "0.0.0.0";
      port = 3000;

      settings = {
        users = [
          {
            name = "guardian";
            password = "$2a$10$CiEE/138p8QjsvkJtK4L0OfPgpLYWRoVy7/xK7XpaqJpsTFgQz.DW";
          }
        ];

        dns = {
          upstream_mode = "load_balance";
          upstream_dns = [
            "https://dns.quad9.net/dns-query"
            "https://dns.adguard-dns.com/dns-query"
            "https://security.cloudflare-dns.com/dns-query"
            "https://base.dns.mullvad.net/dns-query"
          ];

          bootstrap_dns = [
            # quad9
            "9.9.9.10"
            "149.112.112.10"
            "2620:fe::10"
            "2620:fe::fe:10"

            # cloudflare
            "1.1.1.1"
            "1.0.0.1"
            "2606:4700:4700::1111"
            "2606:4700:4700::1001"

            # adguard
            "94.140.14.14"
          ];
        };

        filters =
          map
            (url: {
              enabled = true;
              url = url;
            })
            [
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt" # AdGuard DNS filter
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt" # AdAway Default Blocklist
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt" # The Big List of Hacked Malware Web Sites
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_59.txt" # AdGuard DNS Popup Hosts filter
            ];
      };
    };

    networking.firewall = {
      allowedTCPPorts = [
        3000
        53
      ];

      allowedUDPPorts = [ 53 ];
    };
  };
}
