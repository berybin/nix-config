{
  flake.modules.nixos.system-core =
    { pkgs, ... }:
    {
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
    };
}
