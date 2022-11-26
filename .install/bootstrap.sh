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
checks="SYSTEM DISK HOSTNAME"
for check in $checks; do check_var "${check}"; done
[ $has_error -eq 1 ] && exit 1


##############################################################################
# Volumes
##############################################################################

# Security for not overwriting existant installation
if [ -z "$FORCEINSTALL" ]; then
  if zpool list | grep "${HOSTNAME}" 2>&1 > /dev/null; then
    echo "The ${HOSTNAME} zfs pool already exists"
    exit 1
  fi
fi

# Umount and destroy all zfs volumes
umount -R /mnt 2>/dev/null
if zpool list | grep "${HOSTNAME}" 2>&1 > /dev/null; then
  zfs destroy -r ${HOSTNAME}
  zpool destroy ${HOSTNAME}
fi

# Partition
sgdisk -Z "${DISK}" # wipe all partition
sgdisk -n0:1M:+512M -t 0:EF00 "${DISK}" # EFI partition
sgdisk -n0:0:0 -t 0:8300 "${DISK}" # ZFS partition
echo "waiting partition ..." && partprobe "$disk"

while ! blkid ${DISK}-part2 ; do echo "waiting partition ..." ; sleep 1 ; done

# Format
mkfs.vfat -n BOOT "${DISK}-part1"
zpool create -f -o ashift=12 -O mountpoint=none ${HOSTNAME} "${DISK}-part2"
# public volumes
zfs create -o mountpoint=none -o canmount=off ${HOSTNAME}/public
zfs create -o mountpoint=legacy -o canmount=on -o atime=off ${HOSTNAME}/public/nix
# private volumes(encrypted)
zfs create -o mountpoint=none -o canmount=off -o encryption=aes-256-gcm -o keyformat=passphrase -o keylocation=prompt ${HOSTNAME}/private
zfs create -o mountpoint=legacy -o canmount=on ${HOSTNAME}/private/root
zfs create -o mountpoint=legacy -o canmount=on ${HOSTNAME}/private/data
zfs create -o mountpoint=legacy -o canmount=off ${HOSTNAME}/private/persist
zfs create -o mountpoint=legacy -o canmount=on ${HOSTNAME}/private/persist/host
zfs create -o mountpoint=legacy -o canmount=on ${HOSTNAME}/private/persist/user

# Import all volumes and import encryption volumes key
zpool import -f ${HOSTNAME} 2>/dev/null
zfs load-key ${HOSTNAME}/private 2>/dev/null

# Mount
make mounts HOSTNAME="${HOSTNAME}" DISK="${DISK}"

##############################################################################
# Restore previous /persist
##############################################################################

BORG_REPO=/tmp/persist
if [ -d "${BORG_REPO}" ]; then
  echo ""
  echo "####################################################################"
  echo "# Borg backup restoration"
  echo "####################################################################"
  lastbackup=$(borg list "${BORG_REPO}" | tail -n1 | awk '{ print $1}')
  mkdir -p /tmp/lastbackup && borg mount "${BORG_REPO}::${lastbackup}" /tmp/lastbackup
  rsync -ar /tmp/lastbackup/persist/ /mnt/persist/
fi

##############################################################################
# Install host NixOS
##############################################################################

# Create host ssh key if not exists
mkdir -p /mnt/persist/host/etc/ssh
test -f /mnt/persist/host/etc/ssh/ssh_host_ed25519_key || ssh-keygen -t ed25519 -N '' -f /mnt/persist/host/etc/ssh/ssh_host_ed25519_key

# Create user ssh key if not exists
mkdir -p /mnt/persist/user/.ssh
test -f /mnt/persist/user/.ssh/ssh_host_ed25519_key || ssh-keygen -t ed25519 -N '' -f /mnt/persist/user/.ssh/ssh_host_ed25519_key

# Change permission
chown -R 1000 /mnt/{data,persist/user}

# Install NixOS
DIRCONF=/tmp/nix-config/nixos/hosts/${HOSTNAME}
if [ ! -f ${DIRCONF}/hardware-configuration.nix ]; then
  mkdir -p "${DIRCONF}"
  nixos-generate-config --root /mnt --show-hardware-config > ${DIRCONF}/hardware-configuration.nix

  sed -i -e "/hardware\./i\  nixpkgs.hostPlatform.system = \"$SYSTEM\";" ${DIRCONF}/hardware-configuration.nix
  sed -i -e "/boot\.extraModulePackages/a\
    boot.supportedFilesystems = [ \"zfs\" ];\n\
  \#  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;\n\
  \#  boot.zfs.extraPools = [ \"${HOSTNAME}\" ]; \n\
    boot.loader.systemd-boot.enable = true; \n\
    boot.loader.efi.canTouchEfiVariables = true;\n\
  " ${DIRCONF}/hardware-configuration.nix
  sed -i -e "/networking\.useDHCP/a\ \ networking.hostName = \"${HOSTNAME}\"; \n\  networking.hostId = \"$(head -c 8 /etc/machine-id)\";" ${DIRCONF}/hardware-configuration.nix
fi

# Move 
mkdir -p /mnt/data/tmp/
rsync -ar /tmp/nix-config /mnt/data/tmp/