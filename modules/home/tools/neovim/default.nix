{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.bery.tools.neovim;
in
{
  options.bery.tools.neovim = {
    enable = lib.mkEnableOption "neovim";
    luaPath = lib.mkOption {
      type = lib.types.str;
      description = "path to lua config";
    };
  };

  config =
    let
      coreDependencies = with pkgs; [
        curl
        fd
        fzf
        gcc
        git
        lazygit
        ripgrep
        tree-sitter
      ];

      lazyExtras = [
        "coding.yanky"
        "dap.core"
        "editor.dial"
        "editor.inc-rename"
        "test.core"
        "ui.treesitter-context"
        "util.dot"
        "util.mini-hipatterns"

        "lang.go"
        "lang.json"
        "lang.nix"
        "lang.tailwind"
        "lang.toml"
        "lang.typescript"
        "lang.typescript.vtsls"
        "lang.yaml"
      ];

      languageServers = with pkgs; [
        # LUA
        lua-language-server
        stylua

        # NIX
        nil
        nixfmt
        statix

        # GO
        delve
        impl
        gofumpt
        golangci-lint
        gomodifytags
        gopls
        gotools
        go-tools

        # TYPESCRIPT
        vtsls
        vscode-js-debug

        # VUE
        vue-language-server

        # SH
        shellcheck

        # CSS
        tailwindcss-language-server
      ];

      extraDependencies = with pkgs; [
        shfmt

        oxfmt
        oxlint
        eslint_d
      ];

      # List of all plugins that you want to use.
      # These get turned into a linkFarm directory that Lazy uses
      # as its dev.path (see below).
      lazyPlugins = with pkgs.vimPlugins; [
        blink-cmp
        bufferline-nvim
        # When a plugin's name in nixpkgs doesn't match what Lazy expects,
        # you can manually specify the mapping like this:
        {
          name = "catppuccin";
          path = catppuccin-nvim;
        }
        conform-nvim
        dial-nvim
        flash-nvim
        friendly-snippets
        gitsigns-nvim
        grug-far-nvim
        inc-rename-nvim
        lazy-nvim
        lazydev-nvim
        LazyVim
        lualine-nvim
        mini-ai
        mini-hipatterns
        mini-icons
        mini-pairs
        neo-tree-nvim
        noice-nvim
        nui-nvim
        nvim-lint
        nvim-lspconfig
        nvim-treesitter
        nvim-treesitter-context
        nvim-treesitter-textobjects
        nvim-ts-autotag
        persistence-nvim
        plenary-nvim
        SchemaStore-nvim
        snacks-nvim
        todo-comments-nvim
        tokyonight-nvim
        trouble-nvim
        ts-comments-nvim
        which-key-nvim
        yanky-nvim

        # DAP / TESTING
        neotest
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text
        nvim-nio

        # GO
        neotest-golang
        nvim-dap-go
      ];

      tailwind-plugin = pkgs.vimUtils.buildVimPlugin {
        pname = "tailwindcss-colorizer-cmp.nvim";
        version = "2024-03-23";
        src = pkgs.fetchFromGitHub {
          owner = "roobert";
          repo = "tailwindcss-colorizer-cmp.nvim";
          rev = "3d3cd95e4a4135c250faf83dd5ed61b8e5502b86";
          hash = "sha256-PIkfJzLt001TojAnE/rdRhgVEwSvCvUJm/vNPLSWjpY=";
        };
      };

      customPlugins = with pkgs.vimPlugins; [
        git-blame-nvim
        tailwind-plugin
        tiny-inline-diagnostic-nvim
        vim-flog
        vim-fugitive
      ];

      # NOTE: when using only a few treesitter grammars, make sure
      # to clear ensure_installed in nvim-treesitter
      treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
        p: with p; [
          bash
          c
          diff
          go
          gomod
          gosum
          gowork
          html
          javascript
          jsdoc
          json
          lua
          luadoc
          luap
          markdown
          markdown_inline
          nix
          printf
          python
          query
          regex
          toml
          tsx
          typescript
          vim
          vimdoc
          xml
          yaml
        ]
      );

      #! the following is the glue that puts all of the above together

      # Collect all grammar derivations into a single directory
      # so nvim-treesitter can find them via install_dir
      treesitterGrammars = pkgs.symlinkJoin {
        name = "nvim-treesitter-grammars";
        paths = treesitter.dependencies;
      };

      # Maps a plugin derivation to a { name, path } pair.
      # linkFarm expects this format to create a directory of symlinks
      # where each plugin is accessible by its name.
      mkEntryFromDrv =
        drv:
        if lib.isDerivation drv then
          {
            name = "${lib.getName drv}";
            path = drv;
          }
        else
          drv;

      # Creates a directory with symlinks to all plugins, keyed by name.
      # This is what Lazy uses as its local plugin source via dev.path.
      lazyPath = pkgs.linkFarm "lazy-plugins" (
        builtins.map mkEntryFromDrv (lazyPlugins ++ customPlugins)
      );

      extras = lib.concatMapStringsSep "\n" (
        extra: ''{ import = "lazyvim.plugins.extras.${extra}" },''
      ) lazyExtras;
    in
    lib.mkIf cfg.enable {
      stylix.targets.neovim.enable = false;

      programs.neovim = {
        enable = true;
        vimAlias = true;
        viAlias = true;
        vimdiffAlias = true;
        defaultEditor = true;

        withPython3 = false;
        withRuby = false;

        # Only lazy-nvim itself is loaded as a Neovim plugin.
        plugins = with pkgs.vimPlugins; [ lazy-nvim ];

        extraPackages = coreDependencies ++ languageServers ++ extraDependencies;

        initLua = ''
          require("lazy").setup({
            defaults = {
              lazy = true,
            },
            dev = {
              -- # note: reuse files from pkgs.vimPlugins.*
              path = "${lazyPath}",
              patterns = { "." },
              -- if a plugin isn't found in the linkFarm,
              -- Lazy will fall back to downloading it directly
              fallback = true,
            },
            spec = {
              { "LazyVim/LazyVim", import = "lazyvim.plugins" },

              -- LazyExtras
              ${extras}

              { "mason-org/mason-lspconfig.nvim", enabled = false },
              { "mason-org/mason.nvim", enabled = false },
              { "jay-babu/mason-nvim-dap.nvim", enabled = false },

              -- import/override with your plugins
              { import = "plugins" },

            },
            -- see https://www.lazyvim.org/plugins/colorscheme on how to change/install colorschemes 
            install = { colorscheme = { "habamax", "catppuccin" } },
            checker = { enabled = false }, -- disable automatic update checking
          })

        '';
      };

      xdg.configFile."nvim/lua" = {
        source = config.lib.file.mkOutOfStoreSymlink cfg.luaPath;
        recursive = true;
      };
    };
}
