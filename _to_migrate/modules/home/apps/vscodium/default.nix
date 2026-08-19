{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.apps.vscodium;
in
{

  options.bery.apps.vscodium = {
    enable = lib.mkEnableOption "VSCodium";
  };

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      ripgrep
      python3
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
        ];
      };
    };

  };
}
