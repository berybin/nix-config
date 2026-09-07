{
  flake.modules.homeManager.gopass =
    { pkgs, ... }:
    let
      wl-copy-sensitive = pkgs.writeShellScriptBin "wl-copy-sensitive" ''
        exec ${pkgs.wl-clipboard}/bin/wl-copy --sensitive
      '';
    in
    {
      home.packages = with pkgs; [
        gopass
        wl-copy-sensitive
      ];

      home.sessionVariables.GOPASS_CLIPBOARD_COPY_CMD = "wl-copy-sensitive";
    };
}
