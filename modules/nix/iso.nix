{ self, inputs, ... }: {
  perSystem =
    {
      system,
      ...
    }:
    {
      packages =
        let
          mkImage =
            name:
            (inputs.nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                ./${"../../iso/${name}"}
                self.modules.generic.berynet
                {
                  networking.hostName = name;
                  nixpkgs.hostPlatform = system;
                  nixpkgs.overlays = [ self.overlays.default ];
                }
              ];
            });

          mkIso = image: (mkImage image).config.system.build.isoImage;

        in
        {
          iso-graphical = mkIso "graphical";
          iso-luddite = mkIso "luddite";
          iso-server-bootstrap = mkIso "server-bootstrap";
          iso-digital-ocean = (mkImage "digital-ocean-bootstrap").digitalOceanImage;
        };
    };
}
