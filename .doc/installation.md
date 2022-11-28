## First install
```
# Change keymap & root password
sudo -i
loadkeys fr
passwd 

# WI-FI
systemctl start wpa_supplicant
wpa_cli
add_network
set_network 0 ssid "ssid_name"
set_network 0 psk "password"
enable_network 0

# Connect to nixos installation
ip a
ssh root@<ip>

# Get configuration
cd /tmp
nix develop
git clone https://github.com/badele/nix-config.git
cd nix-config

# [Optional] Copy your previous borg backups at /tmp/persist

# Install bootstrap
make bootstrap HOSTNAME=<hostname> 
make nixos-install TMPDIR=/mnt/data/tmp USERNAME=<username> HOSTNAME=<hostname>
reboot
make nixos-update HOSTNAME=<hostname>
make home-update USERNAME=<username> HOSTNAME=<hostname>
```

## Second install
```
git clone && cd nix-config
nix develop
make nixos-update HOSTNAME=<hostname>
make home-update USERNAME=<username> HOSTNAME=<hostname>
# nix build #.packagename
```
