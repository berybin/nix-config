{ inputs, ... }:
{
  flake.overlays =
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
    in
    {
      default = inputs.nixpkgs.lib.composeManyExtensions [
        inputs.nur.overlays.default
        (mkStablePkg "freecad")
      ];
    };
}
