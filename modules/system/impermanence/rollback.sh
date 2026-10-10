set -euo pipefail

echo "Starting impermanence rollback..."

LUKS_DEVICE="/dev/mapper/cryptroot"

if [[ ! -b $LUKS_DEVICE ]]; then
    echo "Error: No LUKS device found. $LUKS_DEVICE was not a block device."
    exit 0
fi

echo "LUKS device found: $LUKS_DEVICE"

mkdir -p /mnt

if ! mount -o subvol=@ "$LUKS_DEVICE" /mnt; then
    echo "Error: failed to mount root filesystem"
    exit 1
fi

trap "umount /mnt" EXIT

if [[ -d /mnt/root ]]; then
    mkdir -p /mnt/root_backups
    timestamp=$(date --date="@$(stat -c %Y /mnt/root)" "+%Y-%m-%-d_%H:%M:%S")
    echo "Backing up the current root filesystem: /mnt/root_backups/$timestamp..."
    mv /mnt/root "/mnt/root_backups/$timestamp"
fi

delete_subvolume_recursively() {
    btrfs subvolume list -o "$1" | cut -f 9- -d ' ' | while read -r subvolume; do
        delete_subvolume_recursively "/mnt/$subvolume"
    done
    btrfs subvolume delete "$1"
}

# clean up old root backups older than 7 days
find /mnt/root_backups -maxdepth 1 -mtime +7 | while read -r subvolume; do
    delete_subvolume_recursively "$subvolume"
done

btrfs subvolume create /mnt/root
