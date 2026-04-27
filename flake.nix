{
  description = "Jay's NixOS Config / dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets.url = "git+ssh://git@codeberg.org/berybin/nix-secrets.git?shallow=1";
  };

  outputs =
    {
      self,
      nixpkgs,
      colmena,
      ...
    }@inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          namespace = "bery";

          meta = {
            name = "bery";
            title = "my nix config";
          };
        };
      };

    in
    lib.mkFlake {
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      channels-config = {
        allowUnfree = true;
      };

      # Home modules
      home.modules = with inputs; [
      ];

      # System modules
      systems.modules.nixos = with inputs; [
        {
          bery.system.core.enable = true;
        }
      ];

      outputs-builder = channels: {
        # Outputs in the outputs builder are transformed to support each system. This
        # entry will be turned into multiple different outputs like `formatter.x86_64-linux.*`.
        formatter = channels.nixpkgs.nixfmt;
      };

      colmenaHive = lib.mkColmenaHive inputs.self.pkgs.x86_64-linux.nixpkgs {
        thinkpad = {
          targetHost = "thinkpad.local";
          targetUser = "jay";
          buildOnTarget = true;
        };

        toaster = {
          targetHost = "toaster.local";
          targetUser = inputs.nix-secrets.server.core.admin.username;
          tags = [ "homelab" ];
        };

        jukebox = {
          targetHost = "jukebox.local";
          targetUser = inputs.nix-secrets.server.core.admin.username;
          buildOnTarget = true;
          tags = [ "homelab" ];
        };
      };
    };
}
