<div align="center">
  <img src="./docs/images/logo.png" alt="NixOS Logo" width=128 />
  <h1>nix-config</h1>
</div>

This repository contains my infrastructure as code for managing my personal machines and homelab.\
It's a Nix Flake built and organised using the [Flake Parts](https://flake.parts/) framework.

## A few features of my config

- Structured to manage multiple hosts with multiple users
- [**Custom Live Boot ISOs**](#custom-live-boot-isos) for [bootstrapping new machines](#bootstrapping-a-new-machine)
- [**Secrets Management with SOPS and sops-nix**](#secrets-management-with-sops-and-sops-nix)
- [**Declarative disk partitioning and formatting with disko**](#declarative-disk-partitioning-and-formatting-with-disko) / [**Encrypted root filesystem with LUKS and BTRFS**](#encrypted-root-filesystem-with-luks-and-btrfs)
- [**Opt-in filesystem persistence with Impermanence**](#opt-in-filesystem-persistence-with-impermanence)

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

## Bootstrapping a new machine

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

### Bootstrapping an Underspecced VPS

This section is a write up following my trials and tribulations trying to install NixOS using nixos-anywhere on a low spec VPS in Digital Ocean.

Essentially, during the nixos-anywhere installation, `/nix/.rw-store` was too small, causing the installation to grind to a halt.

`nixos-anywhere` runs in several phases. By default it runs phases in order: `kexec,disko,install,reboot`.\
However, you can manually choose which phases run using the `--phases` flag.

To install NixOS on a VPS, I broke it up into `kexec,disko` phases, and `install,reboot` phases.\
Inbetween phases, I had to SSH into the kexec environment and remount the `/nix/.rw-store` with a larger size.

> [!NOTE]
> The `--no-substitute-on-destination` also helps with the installation.
>
> <https://github.com/nix-community/nixos-anywhere/issues/402#issuecomment-2478702807>

#### Run the `kexec,disko` Phase

```shell
nixos-anywhere --flake .#<HOST> \
  --generate-hardware-config nixos-facter ./hosts/<HOST>/<HOST>.facter.json \
  --target-host root@<IP> \
  --no-substitute-on-destination \
  --phases kexec,disko
```

```diff
+ --no-substitute-on-destination \
+ --phases kexec,disko
```

#### After that has completed, SSH into the kexec environment and remount `/nix/.rw-store` with a larger size

```shell
ssh root@<IP>

findmnt /nix/.rw-store
df -h /nix/.rw-store

mount -o remount,size=3G /nix/.rw-store
df -h /nix/.rw-store
```

#### Run the `install,reboot` Phase

```shell
nixos-anywhere --flake .#<HOST> \
  --target-host root@<IP> \
  --no-substitute-on-destination \
  --phases install,reboot
```

```diff
+ --no-substitute-on-destination \
+ --phases kexec,disko
```

</details>

## Secrets Management with SOPS and sops-nix

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

## Declarative disk partitioning and formatting with disko

> [!WARNING]
> This is still a work in progress.

## Encrypted root filesystem with LUKS and BTRFS

> [!WARNING]
> This is also a work in progress.\
> I have it working on a spare device, but I haven't set it up on any machines that I daily drive just yet.

## Opt-in filesystem persistence with Impermanence

> [!WARNING]
> Believe it or not, but this is also a work in progress.

[Impermanence](https://github.com/nix-community/impermanence) lets you choose what files and directories you want to keep between reboots - the rest are thrown away.

I achieve this using BTRFS subvolumes and a `@blank` subvolume snapshot which is created just after [disko](#declarative-disk-partitioning-and-formatting-with-disko) is finished formatting the disk.

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
