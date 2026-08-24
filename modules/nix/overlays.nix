{ inputs, ... }:
{
  flake.overlays = {
    default = inputs.nixpkgs.lib.composeManyExtensions [
      inputs.nur.overlays.default
    ];
  };
}
