# nix-config

Flake based NixOS config for managing my personal devices and homelab. I will use the word `berynet` interchangeably with homelab.


## Bootstrapping a new machine

```bash
nix build .#nixosConfigurations.bootstrap-minimal.config.system.build.isoImage
```

```bash
nix run github:nix-community/nixos-anywhere -- \
  --flake .#<HOST> \
  --generate-hardware-config nixos-facter ./hosts/<HOST>/<HOST>.facter.json \
  --disk-encryption-keys /tmp/secret.key /tmp/secret.key \
  --target-host root@<BOOTSTRAP-HOSTNAME>.local
```


