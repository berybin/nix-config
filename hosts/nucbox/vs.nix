{

  flake.modules.nixos.nucbox = { lib, config, ... }: {
    services.vintagestory-server = {
      enable = true;
      port = config.berynet.vintagestory.port;
      openFirewall = true;
      serverConfig = {
        ServerName = "Bery's Story";
        WorldConfig = {
          AllowCreativeMode = false;
          WorldName = "Bery's World";
        };
      };
      mods = [
        {
          download-id = "131510";
          filename = "Wilderlands+Onus+Moderatus+2.0.5.zip";
          hash = lib.fakeHash;
        }
      ];
    };
  };
}
