{ self, ... }: {
  flake.modules.nixos.system-server = {
    imports = with self.modules.nixos; [
      system-core
      ssh-access
    ];
  };
}
