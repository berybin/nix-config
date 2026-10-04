{
  perSystem = { pkgs, ... }: {
    packages = pkgs.lib.filesystem.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ../../packages;
    };
  };
}
