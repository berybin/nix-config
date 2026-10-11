{ self, inputs, ... }: {
  perSystem =
    {
      lib,
      pkgs,
      config,
      system,
      ...
    }:
    {
      packages =
        let
          mkIso =
            name:
            (inputs.nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                self.modules.nixos.berynet
                "../../iso/${name}.nix"
                {
                  nixpkgs.hostPlatform = system;
                  users.users.root.openssh.authorizedKeys.keys = lib.attrValues config.berynet.keys;
                  environment.systemPackages = with pkgs; [
                    mkberyusb
                  ];
                }
              ];
            }).config.system.build.isoImage;
        in
        {
          iso-graphical = mkIso "graphical";
          iso-luddite = mkIso "luddite";
        };
    };
}
