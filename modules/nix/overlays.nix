{ inputs, ... }:
{
  flake.overlays =
    let
      mkStablePkg = pkgToPin: self: super: {
        ${pkgToPin} = inputs.nixpkgs-stable.legacyPackages.${self.stdenv.hostPlatform.system}.${pkgToPin};
      };
    in
    {
      default = inputs.nixpkgs.lib.composeManyExtensions [
        inputs.nur.overlays.default
        (mkStablePkg "freecad")
      ];
    };
}
