set -euo pipefail

echo "Starting impermanence rollback..."

LUKS_DEVICE="/dev/mapper/cryptroot"
if [[ ! -b $LUKS_DEVICE ]]; then
    echo "Error: No LUKS device found. $LUKS_DEVICE was not a block device."
    exit 0
fi

echo "LUKS device found: $LUKS_DEVICE"

MOUNTPOINT="/mnt"
mkdir -p "$MOUNTPOINT"

if ! mount -t btrfs -o subvol=/ "$LUKS_DEVICE" "$MOUNTPOINT"; then
    echo "Error: failed to mount filesystem"
    exit 1
fi

trap 'umount "$MOUNTPOINT"' EXIT

if [[ ! -e "$MOUNTPOINT/@" ]]; then
    echo "Error: subvolume $MOUNTPOINT/@ is missing or is not a BTRFS subvolume"
    exit 1
fi

if [[ ! -d "$MOUNTPOINT/@blank" ]]; then
    echo "Error: $MOUNTPOINT/@blank snapshot not found, skipping rollback"
    exit 0
fi

ARCHIVE="$MOUNTPOINT/root_archive"
mkdir -p $ARCHIVE

timestamp=$(date "+%Y-%m-%-d_%H:%M:%S_%Z")

echo "Archiving the current root filesystem..."
mv -- $MOUNTPOINT/@ "$ARCHIVE/$timestamp"

find $ARCHIVE -type d -mindepth 1 -maxdepth 1 -mtime +7 | while read -r arch; do
    btrfs subvolume show "$arch" || {
        echo "Not a subvolume; refusing to delete: $arch" >&2
        exit 1
    }

    btrfs subvolume delete --recursive "$arch" || exit 1
done

echo "Restoring root (@) subvolume from @blank"
if ! btrfs subvolume snapshot "$MOUNTPOINT/@blank" "$MOUNTPOINT/@"; then
    echo "Failed to restore root subvolume from the @blank snapshot"
    exit 1
fi

echo "Rollback completed successfully!"
