{
  inputs,
  channels,
  ...
}:

final: prev: {
  inherit (channels.nixpkgs-stable) calibre;
  proton-vpn = channels.nixpkgs-stable.protonvpn-gui;
}
