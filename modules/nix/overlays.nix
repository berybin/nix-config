{ self, inputs, ... }:

let
  pkgs-stable =
    system:
    import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

  mkStablePkg = name: _final: prev: {
    ${name} = (pkgs-stable prev.stdenv.hostPlatform.system).${name};
  };

  localPkgs = _final: prev: self.packages.${prev.stdenv.hostPlatform.system} or { };

in
{
  flake.overlays.default = inputs.nixpkgs.lib.composeManyExtensions [
    localPkgs
    inputs.nur.overlays.default
    inputs.nix-vscode-extensions.overlays.default
    (mkStablePkg "freecad")
  ];
}
