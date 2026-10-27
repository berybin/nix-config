{ self, inputs, ... }:
let
  mkColmenaNode =
    system: hostname: config:
    ((self.lib.mkHostModule system hostname) // config);
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
        tags = [ "berynet" ];
      };
    };

    nucbox = mkColmenaNode "x86_64-linux" "nucbox" {
      deployment = {
        targetHost = "10.42.4.10";
        targetUser = "bery";
        tags = [ "berynet" ];
      };
    };
  };
}
