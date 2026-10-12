<div align="center">
  <img src="./docs/images/logo.png" alt="NixOS Logo" width=128 />
  <h1>nix-config</h1>
</div>

This repository contains my infrastructure as code for managing my personal machines and homelab.\
It's a Nix Flake built and organised using the [Flake Parts](https://flake.parts/) framework.

## A few features of my config

- Structured to manage multiple hosts with multiple users
- [**Custom Live Boot ISOs**](#custom-live-boot-isos) for [bootstrapping new machines](#-bootstrapping-a-new-machine)
- [**Secrets Management with SOPS and sops-nix**](#-secrets-management-with-sops-and-sops-nix)
- [**Declarative disk partitioning and formatting with disko**](#-declarative-disk-partitioning-and-formatting-with-disko) / [**Encrypted root filesystem with LUKS and BTRFS**](#-encrypted-root-filesystem-with-luks-and-btrfs)
- [**Opt-in filesystem persistence with Impermanence**](#-opt-in-filesystem-persistence-with-impermanence)

## Repository Layout

- `hosts/`: host machine definitions (i.e my `nixosConfigurations` output)
- `iso/`: configs for my custom NixOS ISOs
- `modules/`: reusable modules (core system, services, desktop, tooling, etc...)
- `packages/`: custom package definitions
- `users/`: user definitions. these handle both system level and home-manager options

## Custom Live Boot ISOs

Custom ISOs are exposed as packages in my flake outputs.

### Building an ISO

```shell
nix build .#<ISO-NAME>
```

### Available ISOs

- `iso-server-bootstrap`
  - minimal image used to bootstrap servers in my homelab
- `iso-graphical`
  - basic image with KDE Plasma as the desktop manager
- `iso-luddite`
  - the same as iso-graphical but with networking disabled. Used to boot into an air-gapped machine for GPG / YubiKey management
  - **TODO**: bundle docs and some more management pkgs in this one

### Creating a Live Boot USB

```shell
nix build .#iso-server-minimal
sudo dd if=./result/iso/<RESULT_ISO>.iso of=/dev/sdX bs=4M conv=fsync status=progress
```

## 💾 Bootstrapping a new machine

To install NixOS on any of my devices, I use [nixos-anywhere](https://nix-community.github.io/nixos-anywhere/) ([no OS guide](https://nix-community.github.io/nixos-anywhere/howtos/no-os.html)).

Run `nix develop` to drop into a dev shell with all of the necessary tools to bootstrap a new machine. (i.e nixos-anywhere)

<details>
  <summary>
    <strong>📋 Instructions</strong>
  </summary>

### Build and flash a live boot USB

```shell
nix build .#iso-server-minimal
sudo dd if=./result/iso/<RESULT_ISO>.iso of=/dev/sdX bs=4M conv=fsync status=progress
```

### Run nixos-anywhere

```shell
nixos-anywhere -- \
  --flake .#<HOST> \
  --generate-hardware-config nixos-facter ./hosts/<HOST>/<HOST>.facter.json \
  --disk-encryption-keys /path/to/send/remote/secret.key /path/to/local/secret.key \
  --target-host root@<ISO-HOSTNAME>.local
```

#### Hardware Config / NixOS Facter

`nixos-anywhere` can generate a hardware config, or it can use [nixos-facter](https://github.com/nix-community/nixos-facter) to generate a `facter.json` hardware report for you.

This is done with the `--generate-hardware-config` flag.\
The second argument `./hosts/<HOST>/<HOST>.facter.json` specifies where nixos-anywhere will store the hardware report.

In your system configuration you need specify the `hardware.facter.reportPath`, pointing to where nixos-anywhere will save the generated report.

```diff
 nixosConfigurations.generic-nixos-facter = nixpkgs.lib.nixosSystem {
   system = "x86_64-linux";
   modules = [
     ./configuration.nix
+    { hardware.facter.reportPath = ./<HOST>.facter.json; }
   ];
 };
```

#### Disk Encryption Keys

`nixos-anywhere` can upload disk encryption secrets which are necessary during formatting with disko when using LUKS encryption.\
This is done with the `--disk-encryption-keys` flag.

`--disk-encryption-keys /path/to/store/target/secret.key /path/to/local/secret.key`

</details>

## 🔐 Secrets Management with SOPS and sops-nix

Each host has their own sops secret file if needed. Generally stored at `/hosts/<HOST>/secret.yaml`\
The `.sops.yaml` in the root of this repo specifies the recipients of each secret file.

### Rotating a key in a sops secret file

Modify the top level `.sops.yaml` - either adding or removing a key.

```shell
sops updatekeys path/to/secrets.yaml
```

### Some SOPS Resources

- [sops](https://getsops.io/docs/)
- [sops-nix](https://github.com/Mic92/sops-nix)
- [NixOS Secrets Management Video](https://www.youtube.com/watch?v=6EMNHDOY-wo) and [related article](https://unmovedcentre.com/posts/secrets-management/)

## 💽 Declarative disk partitioning and formatting with disko

> [!WARNING]
> This is still a work in progress.

## 🔐 Encrypted root filesystem with LUKS and BTRFS

> [!WARNING]
> This is also a work in progress.\
> I have it working on a spare device, but I haven't set it up on any machines that I daily drive just yet.

## 📁 Opt-in filesystem persistence with Impermanence

> [!WARNING]
> Believe it or not, but this is also a work in progress.

[Impermanence](https://github.com/nix-community/impermanence) lets you choose what files and directories you want to keep between reboots - the rest are thrown away.

I achieve this using BTRFS subvolumes and a `@blank` subvolume snapshot which is created just after [disko](#-declarative-disk-partitioning-and-formatting-with-disko) is finished formatting the disk.

## Reference & Inspiration

- **Benedikt Ritter**
  - [Exploring the Dendritic Nix Pattern blogpost](https://britter.dev/blog/2026/05/11/exploring-the-dendritic-nix-pattern/)
  - [nix-configuration](https://github.com/britter/nix-configuration) on GitHub
- **Haseeb Majid**
  - [BTRFS and LUKS on NixOS Using Disko](https://haseebmajid.dev/posts/2024-07-30-how-i-setup-btrfs-and-luks-on-nixos-using-disko/)
  - [nixicle](https://gitlab.com/hmajid2301/nixicle) on GitLab
- **Not A Number (Pol Dellaiera)**
  - [Refactoring My Infrastructure As Code Configurations](https://not-a-number.io/2025/refactoring-my-infrastructure-as-code-configurations/)
  - [infra](https://github.com/drupol/infra) on GitHub

## Links & Stuff

### Nix Stuff

- [NixOS Package Search](https://search.nixos.org/package)
- [Home Manager Options](https://home-manager-options.extranix.com/)
- [devenv.sh](https://devenv.sh/)
