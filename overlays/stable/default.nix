{
  inputs,
  channels,
  ...
}:

final: prev: {
  inherit (channels.nixpkgs-stable) calibre freecad;
}
