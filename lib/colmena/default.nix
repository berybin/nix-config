# based on https://github.com/zhaofengli/colmena/issues/60#issuecomment-2585780016
{ lib, inputs, ... }:
{
  mkColmenaHive =
    nixpkgs: deployments:
    let
      confs = lib.genAttrs (builtins.attrNames deployments) (
        name: inputs.self.nixosConfigurations.${name}
      );

      colmenaConf = {
        meta = {
          name = "hive bery";
          description = "colmena hive for managing my homelab";

          inherit nixpkgs;
          nodeNixpkgs = builtins.mapAttrs (_name: value: value.pkgs) confs;
          nodeSpecialArgs = builtins.mapAttrs (_name: value: value._module.specialArgs) confs;
        };
      }
      // builtins.mapAttrs (name: value: {
        imports = value._module.args.modules;
        deployment = deployments.${name} or { };
      }) confs;
    in
    inputs.colmena.lib.makeHive colmenaConf;
}
