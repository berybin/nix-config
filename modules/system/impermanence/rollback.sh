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
delete_subvolume() {
    local subvol=$1
    if ! btrfs subvolume show "$subvol" >dev/null 2>&1; then
        echo "WARN: $subvol is not a subvolume - refusing to delete"
        return
    fi

    btrfs subvolume delete --recursive "$subvol" || echo "WARN: Failed to delete $subvol"
}

echo "Deleting archived roots..."
find $ARCHIVE_DIR -mindepth 1 -maxdepth 1 -type d -mtime +3 | while read -r archive; do
    delete_subvolume "$archive"
done

# only keep 10 roots archived `tail -n +11`
find $ARCHIVE_DIR -mindepth 1 -maxdepth 1 -type d | sort | tail -n +11 | while read -r archive; do
    delete_subvolume "$archive"
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
