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

        profiles.default = {
          extensions = with pkgs.open-vsx; [
            astro-build.astro-vscode
            mads-hartmann.bash-ide-vscode
            mk12.better-git-line-blame
            pkgs.vscode-marketplace.ms-vscode.cpptools
            matthewpi.caddyfile-support
            ms-vscode.cmake-tools
            naumovs.color-highlight
            ms-azuretools.vscode-containers
            mkhl.direnv
            docker.docker
            dracula-theme.theme-dracula
            editorconfig.editorconfig
            # microhobby.linuxkerneldev # Embedded Linux Kernel Dev - disabled for now
            dbaeumer.vscode-eslint
            tamasfe.even-better-toml
            eliostruyf.vscode-front-matter
            mhutchie.git-graph
            golang.go
            # ritwickdey.LiveServer
            ms-vscode.makefile-tools
            yzhang.markdown-all-in-one
            davidanson.vscode-markdownlint
            jnoortheen.nix-ide
            pkgs.open-vsx."42crunch".vscode-openapi
            oxc.oxc-vscode
            pioarduino.pioarduino-ide # Fork of PlatformIO: https://github.com/pioarduino/pioarduino-vscode-ide/blob/HEAD/WHY_THIS_FORK.md
            esbenp.prettier-vscode
            yoavbls.pretty-ts-errors
            mechatroner.rainbow-csv
            renesaarsoo.sql-formatter-vsc
            bradlc.vscode-tailwindcss
            vscode-icons-team.vscode-icons
            tomoki1207.pdf
            vue.volar
            redhat.vscode-xml
            redhat.vscode-yaml
            vscodevim.vim
          ];

          userSettings = {
            "chat.disableAIFeatures" = true;
            "chat.agent.enabled" = false;

            "workbench.iconTheme" = "vscode-icons";
            "workbench.colorTheme" = "Dracula Theme";

            "editor.formatOnSave" = true;
            "editor.lineNumbers" = "relative";

            "redhat.telemetry.enabled" = false;
            "[markdown]" = {
              "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
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

            "bashIde.shellcheckPath" = lib.getExe pkgs.shellcheck;
            "bashIde.shfmt.path" = lib.getExe pkgs.shfmt;
          };
        };
      };
    };
}
