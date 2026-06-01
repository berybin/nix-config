{
  inputs,
  channels,
  ...
}:

final: prev: {
  inherit (channels.nixpkgs-stable) calibre bottles;
  proton-vpn = channels.nixpkgs-stable.protonvpn-gui;
}
