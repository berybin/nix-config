{ inputs, ... }:

let
  pkgs-stable =
    system:
    import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

  mkStablePkg = name: _self: super: {
    ${name} = (pkgs-stable super.stdenv.hostPlatform.system).${name};
  };

  localPkgs = final: _prev: import ../../packages { pkgs = final; };

in
{
  flake.overlays.default = inputs.nixpkgs.lib.composeManyExtensions [
    localPkgs
    inputs.nur.overlays.default
    inputs.nix-vscode-extensions.overlays.default
    (mkStablePkg "freecad")
  ];
}
