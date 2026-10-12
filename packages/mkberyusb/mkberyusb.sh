set -euo pipefail
clear

# Check if the user is root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root."
  exit 1
fi

echo Available Devices:
lsblk -d -o NAME,SIZE,MODEL
echo

DEVICE="/dev/$(lsblk -d -o NAME | tail -n +2 | gum choose --header "Please choose a device:")"

clear

FAT_PART="$DEVICE"1
KEY_PART="$DEVICE"2
LUKS_PART="$DEVICE"3
echo "
  This will create:
    - A Generic FAT32 partition on ($FAT_PART)
    - A FAT32 partition for storing luks decryption keys on ($KEY_PART)
    - A LUKS Encrypted BTRFS partition on ($LUKS_PART)
  "

FAT_LABEL=$(gum input --header "What would you like to label the generic FAT32 Partition?" --placeholder "Label..." | tr '[:lower:]' '[:upper:]' | tr -d '[:blank:]')

PASS_CREATE_METHOD=$(gum choose --header "How would you like to create a LUKS passphrase?" "Enter Manually" "Generate")
if [[ $PASS_CREATE_METHOD == "Generate" ]]; then
  LUKS_PASS=$(LC_ALL=C tr -dc "A-Z3-9" </dev/urandom |
    tr -d "IOUS5" |
    head -c "${PASS_LENGTH:-32}" |
    fold -w "${PASS_GROUPSIZE:-4}" |
    paste -sd "${PASS_DELIMITER:--}" -)
else
  LUKS_PASS=$(gum input --header "Enter the passphrase you'd like to use for LUKS")
fi

clear

CONFIRM_MSG="Are you sure you want to:
    - format the USB device ($DEVICE)
    - label the generic FAT32 partition ($FAT_PART) \"$FAT_LABEL\"?
    - Encrypt the LUKS partition with the passphrase: \"$LUKS_PASS\"

  This will erase ALL data on the device!!!"

if ! gum confirm "$CONFIRM_MSG"; then
  echo "Aborting..."
  exit 1
fi

echo "Unmounting the USB device..."
findmnt "$DEVICE" && umount "$DEVICE"
clear

echo "Formatting USB device $DEVICE..."
dd if=/dev/zero of="$DEVICE" bs=1M count=1 status=progress conv=fsync
clear

echo "Partitioning device..."
parted -s "$DEVICE" mktable msdos
parted -s "$DEVICE" mkpart primary 0% 50%
parted -s "$DEVICE" mkpart primary 50% 75%
parted -s "$DEVICE" mkpart primary 75% 100%
clear

echo "Formatting partitions..."
mkfs.vfat "$FAT_PART" -n "$FAT_LABEL"
mkfs.vfat "$KEY_PART" -n KEYS
gum spin \
  --spinner pulse \
  --title "Formatting LUKS container..." \
  -- \
  cryptsetup -q luksFormat "$LUKS_PART" < <(printf '%s' "$LUKS_PASS")
printf '%s' "$LUKS_PASS" | cryptsetup -q luksOpen "$LUKS_PART" crypted

gum spin \
  --spinner pulse \
  --title "Creating btrfs filesystem on LUKS container..." \
  -- \
  mkfs.btrfs /dev/mapper/crypted -L "$(date +%F)-CRYPTED"
cryptsetup luksClose crypted
