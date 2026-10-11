{
  lib,
  pkgs,
  writeShellApplication,
}:

writeShellApplication {
  name = "mod2mp4";
  meta = {
    description = "Converts MOD files to MP4 - used to import video from my JVC Everio Camcorder.";
    license = lib.licenses.mit;
    mainProgram = "mod2mp4";
  };
  runtimeInputs = with pkgs; [
    ffmpeg
    libnotify
  ];

  text = builtins.readFile ./mod2mp4.sh;
}
