{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        inputs.nixos-anywhere.packages.${pkgs.stdenv.hostPlatform.system}.nixos-anywhere
        sops
      ];
    };
  };
}
