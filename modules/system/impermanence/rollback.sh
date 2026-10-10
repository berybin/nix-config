set -euo pipefail
echo "Starting impermanence rollback..."

# ---------------------------------------------------------------------------------
# Mount the unencrypted root volume.
# ---------------------------------------------------------------------------------
LUKS_DEVICE="/dev/mapper/cryptroot"
if [[ ! -b $LUKS_DEVICE ]]; then
    echo "ERROR: No LUKS device found. $LUKS_DEVICE was not a block device."
    exit 0
fi
echo "LUKS device found: $LUKS_DEVICE"
MOUNTPOINT="/mnt"
mkdir -p "$MOUNTPOINT"
if ! mount -t btrfs "$LUKS_DEVICE" "$MOUNTPOINT"; then
    echo "ERROR: failed to mount filesystem"
    exit 1
fi
trap 'umount "$MOUNTPOINT"' EXIT

# ---------------------------------------------------------------------------------
# Archive the previous root volume.
#
# I do this to recover any files/configs I may have forgotten to persist.
# They get auto-deleted after 3 days.
# ---------------------------------------------------------------------------------
ROOT_VOL="$MOUNTPOINT/@"
BLANK_VOL="$MOUNTPOINT/@blank"

if [[ ! -d "$ROOT_VOL" ]]; then
    echo "ERROR: $ROOT_VOL is missing or is not a BTRFS subvolume"
    exit 1
fi

if [[ ! -d "$BLANK_VOL" ]]; then
    echo "ERROR: $BLANK_VOL snapshot not found, skipping rollback"
    exit 0
fi

ARCHIVE_DIR="$MOUNTPOINT/root_archive"
mkdir -p $ARCHIVE_DIR
ARCHIVE_TARGET="$ARCHIVE_DIR/$(date "+%Y-%m-%-d_%H:%M:%S_%Z")"
echo "Archiving the current root filesystem..."
mv -- "$ROOT_VOL" "$ARCHIVE_TARGET"

# ---------------------------------------------------------------------------------
# Delete any archived root volumes older than 3 days
# ---------------------------------------------------------------------------------
echo "Deleting archived roots older than 3 days..."
find $ARCHIVE_DIR -mindepth 1 -maxdepth 1 -type d -mtime +3 | while read -r archive; do
    if ! btrfs subvolume show "$archive" >dev/null 2>&1; then
        echo "WARN: $archive is not a subvolume - refusing to delete"
        continue
    fi

    btrfs subvolume delete --recursive "$archive" || echo "WARN: Failed to delete $archive"
done

# ---------------------------------------------------------------------------------
# Restore the root subvolume from the blank snapshot
# ---------------------------------------------------------------------------------
echo "Restoring @ from @blank"
if ! btrfs subvolume snapshot "$BLANK_VOL" "$ROOT_VOL"; then
    echo "ERROR: Failed to restore root subvolume from the blank snapshot"
    exit 1
fi

echo "Rollback completed successfully!"
