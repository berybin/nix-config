{
  lib,
  pkgs,
  writeShellApplication,
}:

writeShellApplication {
  name = "mkberyusb";
  meta = {
    description = "Formats a USB device the way I like.";
    license = lib.licenses.mit;
    mainProgram = "mkberyusb";
  };
  runtimeInputs = with pkgs; [
    btrfs-progs
    cryptsetup
    gum
    parted
  ];

  text = builtins.readFile ./mkberyusb.sh;
}
