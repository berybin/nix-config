# nix-config

Flake based NixOS config for managing my personal devices and homelab. I will use the word `berynet` interchangeably with homelab.


## Bootstrapping a new machine

```bash
nix build .#nixosConfigurations.minimal.config.system.build.isoImage
```




