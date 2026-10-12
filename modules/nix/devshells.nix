{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        nh # Yet another Nix CLI helper.
        nixos-anywhere
        sops
      ];
    };
  };
}
