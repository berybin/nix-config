{
  inputs,
  ...
}:

final: prev: {
  firefox-extensions = inputs.firefox-extensions.packages.${prev.stdenv.hostPlatform.system};
}
