{
  flake.modules.homeManager.vscodium =
    {
      lib,
      pkgs,
      osConfig,
      ...
    }:
    {
      home.packages = with pkgs; [
        python3
        ripgrep
        uv
        # platformio-core
      ];

      programs.vscodium = {
        enable = true;

        profiles.bery = {
          extensions = with pkgs.open-vsx; [
            # keep-sorted start
            astro-build.astro-vscode
            awalsh128.keep-sorted
            bradlc.vscode-tailwindcss
            davidanson.vscode-markdownlint
            # microhobby.linuxkerneldev # Embedded Linux Kernel Dev - disabled for now
            dbaeumer.vscode-eslint
            docker.docker
            dracula-theme.theme-dracula
            editorconfig.editorconfig
            eliostruyf.vscode-front-matter
            esbenp.prettier-vscode
            golang.go
            jnoortheen.nix-ide
            mads-hartmann.bash-ide-vscode
            matthewpi.caddyfile-support
            mechatroner.rainbow-csv
            mhutchie.git-graph
            mk12.better-git-line-blame
            mkhl.direnv
            ms-azuretools.vscode-containers
            ms-vscode.cmake-tools
            # ritwickdey.LiveServer
            ms-vscode.makefile-tools
            naumovs.color-highlight
            oxc.oxc-vscode
            pioarduino.pioarduino-ide # Fork of PlatformIO: https://github.com/pioarduino/pioarduino-vscode-ide/blob/HEAD/WHY_THIS_FORK.md
            pkgs.open-vsx."42crunch".vscode-openapi
            pkgs.vscode-marketplace.ms-vscode.cpptools
            redhat.vscode-xml
            redhat.vscode-yaml
            renesaarsoo.sql-formatter-vsc
            tamasfe.even-better-toml
            tomoki1207.pdf
            vscode-icons-team.vscode-icons
            vue.volar
            yoavbls.pretty-ts-errors
            yzhang.markdown-all-in-one

            # keep-sorted end
          ];

          userSettings = {
            # keep-sorted start block=yes

            "[markdown]"."editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
            "bashIde.shellcheckPath" = lib.getExe pkgs.shellcheck;
            "bashIde.shfmt.path" = lib.getExe pkgs.shfmt;
            "chat.agent.enabled" = false;
            "chat.disableAIFeatures" = true;
            "editor.codeActionsOnSave" = {
              "source.fixAll.keepSorted" = "explicit";
            };
            "editor.formatOnSave" = true;
            "editor.lineNumbers" = "relative";
            "json.schemaDownload.trustedDomains" = {
              "https://moddbcdn.vintagestory.at/schema/modinfo.latest.json" = true;

              "https://developer.microsoft.com/json-schemas/" = true;
              "https://json-schema.org/" = true;
              "https://json.schemastore.org/" = true;
              "https://raw.githubusercontent.com/devcontainers/spec/" = true;
              "https://raw.githubusercontent.com/microsoft/vscode/" = true;
              "https://schemastore.azurewebsites.net/" = true;
              "https://spec.openapis.org/" = true;
              "https://www.schemastore.org/" = true;
            };
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = lib.getExe pkgs.nixd;
            "nix.serverSettings" = {
              nixd = {
                formatting.command = [ (lib.getExe pkgs.nixfmt-rs) ];
                nixpkgs.expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.${osConfig.networking.hostName}.pkgs";
                options = {
                  nixos.expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.${osConfig.networking.hostName}.options";
                  home-manager.expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.${osConfig.networking.hostName}.options.home-manager.users.type.getSubOptions []";
                  flake-parts.expr = "(builtins.getFlake (toString ./.)).debug.options";
                  flake-parts2.expr = "(builtins.getFlake (toString ./.)).currentSystem.options";
                };
              };
            };
            "redhat.telemetry.enabled" = false;
            "vsicons.dontShowNewVersionMessage" = true;
            "workbench.colorTheme" = "Dracula Theme";
            "workbench.iconTheme" = "vscode-icons";

            # keep-sorted end
          };
        };
      };
    };
}
