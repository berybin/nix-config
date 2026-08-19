{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.gpg;
in
{
  options.bery.tools.gpg = {
    enable = mkEnableOption "gpg";
  };

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
      mutableKeys = false;
      mutableTrust = false;

      publicKeys = [
        {
          # my key
          trust = "ultimate";
          source = pkgs.fetchurl {
            url = "https://github.com/berybin.gpg";
            sha256 = "sha256-EiZjWR0Qji+oeM14Pmqq+klv6svXN/p2bFtZnYWT+hI=";
            # sha256 = lib.fakeSha256;
          };
        }
      ];

      settings = {
        personal-cipher-preferences = "AES256 AES192 AES";
        personal-digest-preferences = "SHA512 SHA384 SHA256";
        personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
        default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
        cert-digest-algo = "SHA512";
        s2k-digest-algo = "SHA512";
        s2k-cipher-algo = "AES256";
        display-charset = "utf-8";
        charset = "utf-8";
        no-comments = true;
        no-emit-version = true;
        keyid-format = "0xlong";
        list-options = "show-uid-validity";
        verify-options = "show-uid-validity";
        with-fingerprint = true;
        require-cross-certification = true;
        no-symkey-cache = true;

        # Enable smartcard
        use-agent = true;
        # Disable recipient key ID in messages (WARNING: breaks Mailvelope)
        throw-keyids = true;
        sig-keyserver-url = "https://github.com/berybin.gpg";

        # when verifying others, use their urls if available
        keyserver-options = "honor-keyserver-url";
        auto-key-retrieve = true;
      };
    };
  };
}
