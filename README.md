# nix-config

Flake based NixOS config for managing my personal devices and homelab. I will use the word `berynet` interchangeably with homelab.

## Bootstrapping a new machine

```bash
nix build .#nixosConfigurations.bootstrap-server.config.system.build.isoImage
```

```bash
nix run github:nix-community/nixos-anywhere -- \
  --flake .#<HOST> \
  --generate-hardware-config nixos-facter ./hosts/<HOST>/<HOST>.facter.json \
  --disk-encryption-keys /tmp/password.key /tmp/password.key \
  --target-host root@<BOOTSTRAP-HOSTNAME>.local
```

## Creating a live boot USB

```bash
nix build .#nixosConfigurations.live-boot.config.system.build.isoImage
zstd -d ./result/iso/nixos-live-boot-....iso.zst | sudo dd of=/dev/sdX bs=4M status=progress conv=fsync
```
