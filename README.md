## Todo

### Completed 🎉
- [x] **AGS** - Need to add system, todo, hidden group, AI chat
- [x] **Hyprland** - Custom & dynamic colors
- [x] **System-wide dynamic colors** - Background, text, accent, overlay, secondary text
- [x] **Anyrun** - Custom dynamic colors
- [x] **GTK** - Fully dynamic custom themes
- [x] **Starship** - Dynamic colors

### In Progress
- [ ] **SWW**
- [ ] **Portable Workstation** - Sway, AGS
- [ ] **Modularize** - Anyrun, ...
- [ ] **QT**


## System
Following hosts are available:
- `milkyway` - main workstation
- `triangulum` - server
- `andromeda` - laptop
- `messier` - iso

## Installation
### Partition and mount the drives using disko
```bash
# Change the disk id according to your system
DISK='/dev/disk/by-id/ata-Samsung_SSD_870_EVO_250GB_S6PENL0T902873K'

curl https://raw.githubusercontent.com/sukhmancs/nyx/main/disko/luks-btrfs-subvolumes/default.nix \
-o /tmp/disko.nix
sed -i "s|to-be-filled-during-installation|$DISK|" /tmp/disko.nix
nix --experimental-features "nix-command flakes" run github:nix-community/disko\
-- --mode disko /tmp/disko.nix
```
### Install the dotfiles
```bash
git clone https://this.repo.url/ ~/.config/nixos-configs
cd ~/.config/nixos-configs

nixos-rebuild switch --flake .#<host>
```
## Thanks

- [MatthiasBenaets](https://github.com/MatthiasBenaets/nix-config/)
- [raf](https://github.com/notashelf/nyx)
- [end-4](https://github.com/end-4/dots-hyprland)
- [aylur](https://github.com/Aylur/dotfiles/)
