{
  pkgs,
  inputs,
  ...
}:

pkgs.mkShell {
  packages = with pkgs; [
    inputs.colmena.packages."${pkgs.stdenv.hostPlatform.system}".colmena
    zstd
  ];

  shellHook = ''
    cat << "EOF"

            ██████   █████  ███                 ███████████                               
            ░░██████ ░░███  ░░░                 ░░███░░░░░███                              
            ░███░███ ░███  ████  █████ █████    ░███    ░███  ██████  ████████  █████ ████
            ░███░░███░███ ░░███ ░░███ ░░███     ░██████████  ███░░███░░███░░███░░███ ░███ 
            ░███ ░░██████  ░███  ░░░█████░      ░███░░░░░███░███████  ░███ ░░░  ░███ ░███ 
            ░███  ░░█████  ░███   ███░░░███     ░███    ░███░███░░░   ░███      ░███ ░███ 
            █████  ░░█████ █████ █████ █████    ███████████ ░░██████  █████     ░░███████ 
            ░░░░░    ░░░░░ ░░░░░ ░░░░░ ░░░░░    ░░░░░░░░░░░   ░░░░░░  ░░░░░       ░░░░░███ 
                                                                                  ███ ░███ 
                                                                                ░░██████  
                                                                                  ░░░░░░   
    EOF

    echo -e "❄️ Nix Config | editing on: $(hostname) ❄️\n"

    echo tools available:
    echo "  - colmena"
    echo "  - zstd"
    echo "    - run 'zstdcat <image> | dd of=/dev/sdX status=progress oflag=sync bs=4m' to write zstd compressed images to an sd-card/usb"
  '';
}
