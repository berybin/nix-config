set -euo pipefail
echo "Starting impermanence rollback..."

# ---------------------------------------------------------------------------------
# Mount the root volume.
# ---------------------------------------------------------------------------------

possible_root_devices=(
    "/dev/mapper/cryptroot"
    "/dev/disk/by-label/nixos"
    "/dev/disk/by-label/root"
)

found_root_device=""

for dev in "${possible_root_devices[@]}"; do
    # This script was running before my VPS was able to setup device nodes and /dev/disk/by-label/ symlinks
    # The following for-loop tries each possible root device for 5 seconds before trying the next.
    # This gives the machine time to set all these up
    for _ in {1..50}; do
        if [[ -b "$dev" ]]; then
            found_root_device="$dev"
            echo "Root device found: $found_root_device"
            break 2
        fi
        sleep 0.1
    done

    echo "INFO: $dev wasn't found, trying next potential block device"

done

if [[ -z "$found_root_device" || ! -b "$found_root_device" ]]; then
    echo "ERROR: no root devices found..."
    exit 1
fi

mountpoint="/mnt"
mkdir -p "$mountpoint"
if ! mount -t btrfs "$found_root_device" "$mountpoint"; then
    echo "ERROR: failed to mount root filesystem"
    exit 1
fi
trap 'umount "$mountpoint"' EXIT

# ---------------------------------------------------------------------------------
# Archive the previous root volume.
#
# I do this to recover any files/configs I may have forgotten to persist.
# They get auto-deleted after 3 days.
# ---------------------------------------------------------------------------------

root_vol="$mountpoint/@"
blank_vol="$mountpoint/@blank"

if [[ ! -d "$root_vol" ]]; then
    echo "ERROR: $root_vol is missing or is not a BTRFS subvolume"
    exit 1
fi

if [[ ! -d "$blank_vol" ]]; then
    echo "ERROR: $blank_vol snapshot not found, skipping rollback"
    exit 0
fi

archive_dir="$mountpoint/root_archive"
mkdir -p "$archive_dir"
archive_target="$archive_dir/$(date "+%Y-%m-%-d_%H:%M:%S_%Z")"
echo "Archiving the current root filesystem..."
mv -- "$root_vol" "$archive_target"

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
find $archive_dir -mindepth 1 -maxdepth 1 -type d -mtime +3 | while read -r archive; do
    delete_subvolume "$archive"
done

# only keep 10 roots archived `tail -n +11`
find $archive_dir -mindepth 1 -maxdepth 1 -type d | sort | tail -n +11 | while read -r archive; do
    delete_subvolume "$archive"
done

# ---------------------------------------------------------------------------------
# Restore the root subvolume from the blank snapshot
# ---------------------------------------------------------------------------------
echo "Restoring @ from @blank"
if ! btrfs subvolume snapshot "$blank_vol" "$root_vol"; then
    echo "ERROR: Failed to restore root subvolume from the blank snapshot"
    exit 1
fi

echo "Rollback completed successfully!"
