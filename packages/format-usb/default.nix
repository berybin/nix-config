{
  lib,
  pkgs,
  writeShellScriptBin,
}:
let
  gum = lib.getExe pkgs.gum;
  parted = lib.getExe pkgs.parted;
  cryptsetup = lib.getExe pkgs.cryptsetup;
in
writeShellScriptBin "format-usb" ''
  # Check if the user is root
  if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
  fi

  printf '\nAvailable Devices:\n\n'
  lsblk -d -o NAME,SIZE,MODEL

  printf '\nPlease choose a device:\n'
  DEVICE="/dev/$(lsblk -d -o NAME | tail -n +2 | ${gum} choose)"


  FAT_PART="$DEVICE"1
  LUKS_PART="$DEVICE"2
  printf "\nThis will create:\n\t- FAT32 partition on $FAT_PART\n\t- LUKS Encrypted BTRFS partition on $LUKS_PART\n\n"

  FAT_LABEL=$(${gum} input --header "What would you like to label the FAT32 Partition?" --placeholder "Label..." | tr '[:lower:]' '[:upper:]')

  CONFIRM_MSG="Are you sure you want to:
    - format the USB device $DEVICE
    - label the FAT32 partition ($FAT_PART) '$FAT_LABEL'?

  This will erase all data on the device!!"

  if ! $(${gum} confirm "$CONFIRM_MSG"); then
      echo "Aborting..."
      exit 1
  fi

  printf "\nFormatting USB device $DEVICE...\n"
''
