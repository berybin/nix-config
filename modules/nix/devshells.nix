{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        colmena
        nh # Yet another Nix CLI helper.
        nixos-anywhere
        sops
      ];
    };
  };
}
