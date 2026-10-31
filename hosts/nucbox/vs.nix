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

      # nix store prefetch-file --json "URL" | jq -r .hash
      mods = [
        {
          filename = "131510/Wilderlands+Onus+Moderatus+2.0.5.zip";
          hash = "sha256-wGDNndRRjGGd+hVEgoVVfUTQ5DqR+41f4NzXMdmDu98=";
        }
      ];
    };
  };
}
