#!/usr/bin/env bash

has_error=0
function check_var() {
    var_name="${1}"
    if [ -z "${!var_name}" ]; then
        echo "Please export '\$$1' variable"
        has_error=1
    fi
}

# Check variables
checks="system disk username hostname"
for check in $checks; do check_var "${check}"; done
[ $has_error -eq 1 ] && exit 1


# Partition
sgdisk -Z "${disk}" # wipe all partition
sgdisk -n0:1M:+512M -t 0:EF00 "${disk}" # EFI partition
sgdisk -n0:0:0 -t 0:8300 "${disk}" # ZFS partition
echo "waiting partition ..." && partprobe "$disk"

while ! blkid ${disk}-part2 ; do echo "waiting partition ..." ; sleep 1 ; done

# Format
mkfs.vfat "${disk}-part1"
zpool create -f -o ashift=12 -O mountpoint=none $hostname "${disk}-part2"
zfs create -o mountpoint=none -o canmount=off -o encryption=aes-256-gcm -o keyformat=passphrase -o keylocation=prompt $hostname/local
zfs create -o mountpoint=legacy -o canmount=on $hostname/local/root
zfs create -o mountpoint=legacy -o canmount=on -o atime=off $hostname/local/nix
zfs create -o mountpoint=legacy -o canmount=on $hostname/data
zfs create -o mountpoint=legacy -o canmount=off $hostname/persist
zfs create -o mountpoint=legacy -o canmount=on $hostname/persist/host
zfs create -o mountpoint=legacy -o canmount=on $hostname/persist/user

zpool import -f latino
zfs load-key latino/local
# Mount
mount -t zfs $hostname/local/root /mnt
mkdir -p /mnt/{boot,nix,data,persist/host,persist/user}
mount "${disk}-part1" /mnt/boot
mount -t zfs $hostname/local/nix /mnt/nix
mount -t zfs $hostname/data /mnt/data
mount -t zfs $hostname/persist/host /mnt/persist/host
mount -t zfs $hostname/persist/user /mnt/persist/user

# Create host ssh key if not exists
mkdir -p /tmp/nix-config/system/hosts/${hostname} /mnt/persist/host/etc/ssh
# ed25519
test -f /tmp/nix-config/system/hosts/${hostname}/ssh_host_ed25519_key.pub || ssh-keygen -t ed25519 -N '' -f /mnt/persist/host/etc/ssh/ssh_host_ed25519_key
test -f /mnt/persist/host/etc/ssh/ssh_host_ed25519_key.pub && mv /mnt/persist/host/etc/ssh/ssh_host_ed25519_key.pub /tmp/nix-config/system/hosts/${hostname}/
# rsa 
# TODO: remove this
# test -f /tmp/nix-config/system/hosts/${hostname}/ssh_host_rsa_key.pub || ssh-keygen -b 4096 -N '' -f /mnt/persist/host/etc/ssh/ssh_host_rsa_key
# test -f /mnt/persist/host/etc/ssh/ssh_host_rsa_key.pub && mv /mnt/persist/host/etc/ssh/ssh_host_rsa_key.pub /tmp/nix-config/system/hosts/${hostname}/

# Create user ssh key if not exists
mkdir -p /tmp/nix-config/home/users/${username} /mnt/persist/user/.ssh
test -f /tmp/nix-config/home/users/${username}/ssh_host_ed25519_key.pub || ssh-keygen -t ed25519 -N '' -f /mnt/persist/user/.ssh/ssh_host_ed25519_key
test -f /mnt/persist/user/.ssh/ssh_host_ed25519_key.pub && mv /mnt/persist/user/.ssh/ssh_host_ed25519_key.pub /tmp/nix-config/home/users/${username}/

# Change permission
chown -R 1000 /mnt/{data,persist/user}

# Install NixOS
CONF=/tmp/nix-config/system/hosts/${hostname}/hardware-configuration.nix
nixos-generate-config --root /mnt --show-hardware-config > $CONF
sed -i -e "/hardware\./i\  nixpkgs.hostPlatform.system = \"$system\";" $CONF
sed -i -e "/boot\.extraModulePackages/a\
  boot.supportedFilesystems = [ \"zfs\" ];\n\
\#  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;\n\
\#  boot.zfs.extraPools = [ \"$hostname\" ]; \n\
  boot.loader.systemd-boot.enable = true; \n\
  boot.loader.efi.canTouchEfiVariables = true;\n\
" $CONF
sed -i -e "/networking\.useDHCP/a\ \ networking.hostName = \"$hostname\"; \n\  networking.hostId = \"$(head -c 8 /etc/machine-id)\";" $CONF

nix-shell -p git --run "'nixos-install --no-root-passwd --flake .#${hostname}'"