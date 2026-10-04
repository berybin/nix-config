set -euxo pipefail

# Check if the user is root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

echo Available Devices:
lsblk -d -o NAME,SIZE,MODEL
echo

DEVICE="/dev/$(lsblk -d -o NAME | tail -n +2 | gum choose --header "Please choose a device:")"

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

CONFIRM_MSG="Are you sure you want to:
    - format the USB device ($DEVICE)
    - label the generic FAT32 partition ($FAT_PART) '$FAT_LABEL'?

  This will erase ALL data on the device!!!"

if ! gum confirm "$CONFIRM_MSG"; then
    echo "Aborting..."
    exit 1
fi

echo "Unmounting the USB device..."
findmnt "$DEVICE" && umount "$DEVICE"

echo "Formatting USB device $DEVICE..."
gum spin --show-output --spinner pulse --title "Zeroing out old partition table..." -- dd if=/dev/zero of="$DEVICE" bs=1M count=1 status=progress conv=fsync

echo "Partitioning device..."
parted -s "$DEVICE" mktable msdos
parted -s "$DEVICE" mkpart primary 0% 50%
parted -s "$DEVICE" mkpart primary 50% 75%
parted -s "$DEVICE" mkpart primary 75% 100%

echo "Formatting partitions..."
mkfs.vfat "$FAT_PART" -n "$FAT_LABEL"
mkfs.vfat "$KEY_PART" -n KEYS
cryptsetup -q luksFormat "$LUKS_PART"
cryptsetup -q luksOpen "$LUKS_PART" crypted
mkfs.btrfs /dev/mapper/crypted -L "$(date +%F)-CRYPTED"
cryptsetup luksClose crypted
