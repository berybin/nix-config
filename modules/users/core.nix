{ self, ... }:
{
  flake.modules.homeManager.user-core = {
    imports = with self.modules.homeManager; [
      user-identity
    ];
  };
}
