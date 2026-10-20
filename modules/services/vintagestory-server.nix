{
  flake.modules.nixos.vintagestory-server =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      name = "vintagestory";
      cfg = config.services.vintagestory-server;
    in
    {

      options.services.vintagestory-server = {
        enable = lib.mkEnableOption "Vintage Story Server";

        user = lib.mkOption {
          type = lib.types.str;
          default = name;
          description = "User account under which the Vintage Story server runs.";
        };

        group = lib.mkOption {
          type = lib.types.str;
          default = name;
          description = "Group account under which the Vintage Story server runs.";
        };

        dataDir = lib.mkOption {
          type = lib.types.path;
          default = "/var/lib/${name}";
          description = ''
            The directory where the Vintage Story server will store its state, server config,
            backups, cache, etc. If left as the default value, this directory will be automatically
            created. Otherwise, you are responsible for ensuring it exists.
          '';
        };

        serverConfig = lib.mkOption {
          type = lib.types.attrsOf lib.types.json;
          default = { };
          description = ''
            Partial overrides for the Vintage Story serverconfig.json file.

            Before the service starts, the configuration here is merged into
            the existing serverconfig.json. If there is no serverconfig.json,
            the default will be generated for you. You will need to restart
            the service to apply any declarative changes.

            This is not a fully declarative configuration: the game can change values
            while running and write them back to the file. Values specified here are
            reapplied at the next service start - they are not continuously enforced
            while the server is running.
          '';
        };

        port = lib.mkOption {
          type = lib.types.port;
          default = 42420;
          description = "Listening port.";
        };

        openFirewall = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = ''
            Whether to open the firewall for the specified server port.
          '';
        };

        package = lib.mkPackageOption pkgs "vintagestory-server" {
          example = "pkgs.vintagestory";
          extraDescription = ''
            You may choose to use `pkgs.vintagestory` if you want to install both the
            client and server binaries.
          '';
        };
      };

      config = lib.mkIf cfg.enable {
        systemd.services.vintagestory-server = {
          description = "Vintage Story Server Service";
          wantedBy = [ "multi-user.target" ];
          after = [ "network.target" ];

          preStart =
            let
              serverconfigOverridesFile = pkgs.writeText "serverconfig-overrides.json" (
                builtins.toJSON cfg.serverConfig
              );
            in
            ''
              set -euo pipefail

              server_config=${lib.escapeShellArg "${cfg.dataDir}/serverconfig.json"}

              if [ ! -f "$server_config" ]; then
                echo "serverconfig.json does not exist yet - skipping overrides"
                exit 0
              fi

              tmp="$(mktemp)"
              trap 'rm -f "$tmp"' EXIT

              ${lib.getExe pkgs.jq} -s '.[0] * .[1]' \
                "$server_config" "${serverconfigOverridesFile}" > "$tmp"

              cat "$tmp" > "$server_config"
            '';

          serviceConfig = lib.mkMerge [
            {
              ExecStart = "${cfg.package}/bin/vintagestory-server --dataPath ${cfg.dataDir} --port ${cfg.port}";
              Restart = "always";
              User = cfg.user;
              Group = cfg.group;
              WorkingDirectory = cfg.dataDir;

              # Hardening
              CapabilityBoundingSet = [ "" ];
              DevicePolicy = "closed";
              PrivateTmp = true;
              ProtectHome = true;
              ProtectSystem = "strict";
              NoNewPrivileges = true;
              LockPersonality = true;
              PrivateDevices = true;
              PrivateMounts = true;
              PrivateUsers = true;
              ProcSubset = "pid";
              ProtectClock = true;
              ProtectControlGroups = true;
              ProtectHostname = true;
              ProtectKernelLogs = true;
              ProtectKernelModules = true;
              ProtectKernelTunables = true;
              ProtectProc = "invisible";
              RemoveIPC = true;
              RestrictAddressFamilies = [
                "AF_INET"
                "AF_INET6"
                "AF_NETLINK" # used for network interface enumeration
                "AF_UNIX"
              ];
              RestrictNamespaces = true;
              RestrictRealtime = true;
              RestrictSUIDSGID = true;
              SystemCallArchitectures = "native";
              UMask = "0077";
            }
            (lib.mkIf (cfg.dataDir == "/var/lib/${name}") {
              # Provision the default data directory
              StateDirectory = name;
              StateDirectoryMode = "0700";
            })
            (lib.mkIf (cfg.dataDir != "/var/lib/${name}") {
              # The user provides their own data directory
              ReadWritePaths = [ cfg.dataDir ];
            })
          ];
        };

        users.users = lib.optionalAttrs (cfg.user == name) {
          ${name} = {
            isSystemUser = true;
            description = "Vintage Story server service user";
            group = cfg.group;
            home = cfg.dataDir;
            createHome = true;
          };
        };

        users.groups = lib.optionalAttrs (cfg.group == name) {
          ${name} = { };
        };

        networking.firewall = lib.mkIf cfg.openFirewall {
          allowedUDPPorts = [ cfg.port ];
          allowedTCPPorts = [ cfg.port ];
        };
      };
    };
}
