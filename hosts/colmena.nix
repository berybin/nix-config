{ self, inputs, ... }:
let
  mkColmenaNode =
    system: hostname: config:
    ((self.lib.mkCoreSystem system hostname) // config);
in
{
  flake.colmenaHive = inputs.colmena.lib.makeHive {
    meta = {
      nixpkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        overlays = [ self.overlays.default ];
      };
    };

    droplet = mkColmenaNode "x86_64-linux" "droplet" {
      deployment = {
        targetHost = "vs.berybin.dev";
        targetUser = "bery";
      };
    };
  };
}
