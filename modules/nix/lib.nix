{
  lib,
  self,
  inputs,
  ...
}:
{
  flake.lib = {
    mkNixos = system: hostname: {
      ${hostname} = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          self.modules.nixos.${hostname} or self.modules.bootstrap.${hostname}
          {
            networking.hostName = hostname;
            nixpkgs.hostPlatform = lib.mkDefault system;
            nixpkgs.overlays = [ self.overlays.default ];
          }
        ];
      };
    };

    # inspired by https://not-a-number.io/2025/refactoring-my-infrastructure-as-code-configurations/#:~:text=loadNixosAndHmModuleForUser
    loadNixosAndHmModulesForUser =
      config: modules: username:
      assert builtins.isAttrs config;
      assert builtins.isList modules;
      assert builtins.isString username;
      {
        imports = [
          inputs.home-manager.nixosModules.home-manager
          self.modules.nixos.${username}
        ]
        ++ (builtins.map (module: self.modules.nixos.${module} or { }) modules) # Import NixOS modules
        ++ [
          {
            # Import home-manager modules from both the modules list arg, as well as anything the user has specified in their home manager config
            home-manager.users.${username}.imports = [
              self.modules.homeManager.${username}
            ]
            ++ builtins.map (module: self.modules.homeManager.${module} or { }) modules;
          }
        ];
      };
  };
}
