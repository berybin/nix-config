{
  lib,
  pkgs,
  writeShellApplication,
}:

writeShellApplication {
  name = "nix-fetch-sri";
  derivationArgs.version = "1.0";
  meta = {
    description = "Prefetches and prints the SRI hash format of a URL.";
    license = lib.licenses.mit;
    mainProgram = "nix-fetch-sri";
  };
  runtimeInputs = with pkgs; [
    jq
  ];

  text = ''
    if [[ $# -ne 1 ]]; then
      echo "usage: nix-fetch-sri <URL>"
      return 2
    fi

    nix store prefetch-file --json "$1" | jq -er '.hash'
  '';
}
