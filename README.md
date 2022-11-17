# nix-config

## TODO 
- [ ] Fixs
  - [ ] FIX zsh-syntax-highlighting: unhandled ZLE widget '_navi_widget' (via SSH)
  - [ ] FIX swaylock password authentification
- [ ] Fonts
  - [ ] https://erikflowers.github.io/weather-icons/
- [ ] Sops
- kitty
  - [ ] unmap some keys
  - [ ] disable exit message
- [x] nix-index-database
  - [x] Add cron (@reboot)
- [x] Configure visual studio code
  - [x] Install treetodo
  - [x] Install run on save
  - [x] Install task explorer
- [ ] Hardwares
  - [ ] Dell E5540
    - [ ] push to nixos-hardware
- [ ] Reduce boot generation list
- [ ] autologin
- [ ] ranger
  - [ ] image support
- [ ] install sway
  - [ ] swayidle
  - [ ] swaylock

## Second install
```
git clone && cd nix-config
nix-shell
username=$USERNAME hostname=$HOST ./deploy.sh
# nix build #.packagename
```

## First install
```
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

# Connecto to nixos installation
ip a
ssh root@<ip>

# Get configuration
cd /tmp
git clone nix-config
cd nix-config

# Install new computer
export system=x86_64-linux
export disk=/dev/disk/by-id/ata-Samsung_SSD_850_EVO_500GB_S2RBNX0K135135M
export hostname=latino
export username=badele

./bootstrap.sh
./deploy.sh
```
