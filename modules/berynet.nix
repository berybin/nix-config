{
  flake.modules.generic.berynet = { lib, ... }: {
    options.berynet = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      default = { };
      description = ''
        System-wide variables used across my systems / homelab (berynet).
      '';
    };

    config.berynet = {
      keys = {
        yubikey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBY2m6UXON7EzfrIoNVGfa99w7DsErR3YhYzRhlpS+ni openpgp:0x6CDB2DFE";
        jay-t14 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqoKekYddKVQDqQ6Leavuxqq6kT7/nJy33dMA5E2eMj jay@t14";
        jay-workstation = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOuTx2oW/e+l/LjMFS4TEw7EkMgWYTU5ZttyuJN67HPi jays nixos desktop";
      };
    };
  };
}
