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
      jsonFormat = pkgs.formats.json { };
      yamlFormat = pkgs.formats.yaml { };

      # handle mod installation
      vsModTree = pkgs.linkFarm "${name}-mods" (
        map (mod: {
          name = (baseNameOf mod.filename);
          path = pkgs.fetchurl {
            name = (baseNameOf mod.filename);
            inherit (mod) url hash;
          };
        }) cfg.mods
      );

      syncMods = pkgs.writeShellApplication {
        name = "${name}-sync-server-mods";
        runtimeInputs = [ pkgs.rsync ];
        text = ''
          dest="${cfg.dataDir}/Mods"
          mkdir -p "$dest"
          rsync -rL --delete ${vsModTree}/ "$dest/"
        '';
      };

      isYamlFile = pathStr: lib.hasSuffix "yaml" pathStr || lib.hasSuffix "yml" pathStr;

      # handle mod config overrides
      modConfigOverrideFiles = lib.mapAttrsToList (file: overrides: {
        name = file;
        path =
          if (isYamlFile file) then
            yamlFormat.generate file overrides
          else
            jsonFormat.generate file overrides;
      }) cfg.modConfigOverrides;

      modConfigOverrideDir = pkgs.linkFarm "${name}-mod-config-overrides" modConfigOverrideFiles;

      overrideModConfigScript = pkgs.writeShellApplication {
        name = "${name}-override-mod-configs";
        runtimeInputs = [
          pkgs.jq
          pkgs.yq-go
          pkgs.coreutils
        ];
        text = ''
          for mod_override_file in ${lib.escapeShellArg modConfigOverrideDir}/*; do
            [ -e "$mod_override_file" ] || continue

            mod_config_filename=$(basename "$mod_override_file")

            mod_config="${cfg.dataDir}/ModConfig/$mod_config_filename"
            if [ ! -s "$mod_config" ]; then
                echo "$mod_config does not exist - skipping overrides..."
                continue
            fi

            echo "$mod_config exists - applying overrides..."
            tmp="$(mktemp "${cfg.dataDir}/ModConfig/.$mod_config_filename.XXXXXX")"
            trap 'rm -f "$tmp"' EXIT

            if [[ "$mod_config_filename" == *.yaml || "$mod_config_filename" == *.yml ]]; then
              yq -n "load(\"$mod_config\") * load(\"$mod_override_file\")" > "$tmp"
            elif [[ "$mod_config_filename" == *.json ]]; then
              jq -s '.[0] * .[1]' <(sed -E '/^[[:space:]]*\/\//d' "$mod_config") "$mod_override_file" > "$tmp"
            else
              echo "$mod_config_filename is an invalid config type, skipping overrides..."
              continue
            fi

            chmod --reference "$mod_config" "$tmp"
            mv -f -- "$tmp" "$mod_config"
          done
        '';
      };

      # handle server config overrides
      serverconfigOverridesFile = jsonFormat.generate "serverconfig-overrides.json" cfg.serverConfig;
      overrideServerConfigScript = pkgs.writeShellApplication {
        name = "${name}-override-serverconfig";
        runtimeInputs = [
          pkgs.jq
          pkgs.coreutils
        ];
        text = ''
          server_config="${cfg.dataDir}/serverconfig.json"

          if [ ! -f "$server_config" ]; then
            echo "serverconfig.json does not exist yet - skipping overrides..."
            exit 0
          fi

          tmp="$(mktemp "${cfg.dataDir}/.serverconfig.json.XXXXXX")"
          trap 'rm -f "$tmp"' EXIT

          # https://stackoverflow.com/questions/19529688/how-to-merge-2-json-objects-from-2-files-using-jq#24904276
          jq -s '.[0] * .[1]' "$server_config" "${serverconfigOverridesFile}" > "$tmp"

          chmod --reference "$server_config" "$tmp"
          mv -f -- "$tmp" "$server_config"
        '';
      };

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
          type = lib.types.attrsOf jsonFormat.type;
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

        mods = lib.mkOption {
          type = lib.types.listOf (
            lib.types.submodule (
              { config, ... }: {
                options = {
                  filename = lib.mkOption {
                    type = lib.types.strMatching "[a-zA-Z0-9/.+_-]+\\.zip";
                    example = "123599/primitivesurvival_5.1.4.zip";
                    description = ''
                      Zip filename as it appears in the ModDB URL (must also include the download ID number).
                      Mod authors don't follow a strict naming scheme, so this wildly varies between mods.
                    '';
                  };

                  hash = lib.mkOption {
                    type = lib.types.str;
                    example = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
                    default = lib.fakeHash;
                    description = "Mod source hash.";
                  };

                  url = lib.mkOption {
                    type = lib.types.str;
                    readOnly = true;
                    default = "https://mods.vintagestory.at/download/${config.filename}";
                  };
                };
              }
            )
          );
          default = [ ];
          description = "Mods to install into the `/Mods` directory under `services.vintagestory-server.dataDir`";
          example = lib.literalExpression ''
            [ 
              { 
                filename = "135049/berys-belt-crafting-v1.0.1.zip";
                hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
              }
            ];
          '';
        };

        modConfigOverrides = lib.mkOption {
          type = lib.types.attrsOf (lib.types.attrsOf (lib.types.either jsonFormat.type yamlFormat.type));
          default = { };
          description = ''
            Partial overrides for Vintage Story mods, keyed by the original config filename.

            Behaves similarly to the serverConfig option, but for specific mod config files.
            Each override object is recursively merged into the matching generated config
            before the service starts. Override values take precedence; unspecified keys
            retain the game's defaults. Config files that have not yet been generated by the game are skipped.
          '';
          example = lib.literalExpression ''
            "example-mod.json" = {
              Key = "value";
              Enabled = true;
            };
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

          restartTriggers = [
            vsModTree
            serverconfigOverridesFile
          ];

          preStart = ''
            ${lib.getExe overrideServerConfigScript}
            ${lib.getExe syncMods}
            ${lib.getExe overrideModConfigScript}
          '';

          serviceConfig = lib.mkMerge [
            {
              ExecStart = "${cfg.package}/bin/vintagestory-server --dataPath ${cfg.dataDir} --port ${toString cfg.port}";
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
