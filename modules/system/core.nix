{ self, ... }: {
  flake.modules.nixos.system-core =
    { pkgs, ... }:
    {
      imports = [
        self.modules.nixos.ssh-access
        self.modules.generic.berynet
      ];

      nixpkgs.config.allowUnfree = true;
      nix = {
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };

      time.timeZone = "Australia/Sydney";
      i18n.defaultLocale = "en_AU.UTF-8";

      environment.systemPackages = with pkgs; [
        curl
        git
        neovim
        nh
        wget
      ];

      services.avahi = {
        enable = true;
        nssmdns4 = true;
        settings.publish.publish-addresses = true;
      };
    };
}
