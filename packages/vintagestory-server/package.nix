{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  versionCheckHook,
  dotnet-runtime_10,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "vintagestory-server";
  version = "1.22.7";

  src = fetchurl {
    url = "https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${finalAttrs.version}.tar.gz";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  };

  __structuredAttrs = true;

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/vintagestory $out/bin
    cp -r * $out/share/vintagestory
    rm -rvf $out/share/vintagestory/server.sh

    runHook postInstall
  '';

  preFixup = ''
    makeWrapper ${lib.getExe dotnet-runtime_10} $out/bin/vintagestory-server \
      --add-flags $out/share/vintagestory/VintagestoryServer.dll
  '';

  doInstallCheck = true;
  installCheckInputs = [ versionCheckHook ];

  meta = {
    description = "In-development indie sandbox game about innovation and exploration";
    homepage = "https://www.vintagestory.at/";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryBytecode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "vintagestory-server";
  };
})
