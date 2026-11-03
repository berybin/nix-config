mount -t btrfs /dev/disk/by-label/nixos /mnt
trap 'umount "/mnt"' EXIT

# Create the blank snapshot for impermanence rollback
btrfs subvolume snapshot -r /mnt/@ /mnt/@blank

# Pre-create critical directories in /persist for first boot
# This is essential for nixos-anywhere + impermanence to work
mkdir -p /mnt/@persist/{root,srv,etc/nixos,etc/ssh}
mkdir -p /mnt/@persist/var/{spool,cache,db}
mkdir -p /mnt/@persist/var/lib/{nixos,systemd,dbus,bluetooth,NetworkManager}
mkdir -p /mnt/@persist/var/lib/systemd/{coredump,timers,timesync}
mkdir -p /mnt/@persist/var/db/sudo
mkdir -p /mnt/@persist/etc/NetworkManager/system-connections

# Set proper permissions
chmod 700 /mnt/@persist/root
chmod 700 /mnt/@persist/var/db/sudo
chmod 700 /mnt/@persist/etc/NetworkManager/system-connections
