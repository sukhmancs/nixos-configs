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


## Host
Following hosts are available:

| Host       | Type      |
| ------------ | ---------------- |
| `milkyway`   | Main Workstation |
| `triangulum` | Server           |
| `andromeda`  | Laptop           |
| `messier`    | Iso              |
## Color Scheme
Following color schemes are available:

| Scheme             | Variants                                                                                            |
| ------------------ | --------------------------------------------------------------------------------------------------- |
| `cappuccino-mocha` | default (with <span style="background-color: #cba6f7; color: black">mauve</span> as the base color) |
| `dracula`          | -                                                                                                   |
| `gruvbox`          | light, dark, medium, hard                                                                           |
| `henna`            | -                                                                                                   |
| `helios`           | -                                                                                                   |
| `horizon`          | dark                                                                                                |
| `nord`             | -                                                                                                   |
| `monokai`          | -                                                                                                   |
| `selenized`        | dark, light                                                                                         |
| `solarized`        | dark, light                                                                                         |
| `tomorrow-night`   | -                                                                                                   |
| `twilight`         | -                                                                                                   |
| `ubuntu`           | -                                                                                                   |
| `uwunicorn`        | -                                                                                                   |
| `windows-95`       | -                                                                                                   |
| `doom-one`         | -                                                                                                   |
| `alph`             | -                                                                                                   |
| `ashes`            | -                                                                                                   |
| `atelier`          | cave, dune, estuary, forest, heath, lakeside, meadow, plateu, savanna, seaside, studio, sulphurpool |
| `ayu-dark`         | -                                                                                                   |
| `bespin`           | -                                                                                                   |
| `caret`            | -                                                                                                   |
| `darkmoss`         | -                                                                                                   |
| `ember`            | -                                                                                                   |
| `emil`             | -                                                                                                   |
| `eris`             | -                                                                                                   |
| `eva`              | -                                                                                                   |
| `everforest`       | -                                                                                                   |
| `fairy-floss`      | -                                                                                                   |
| `gigavolt`         | -                                                                                                   |
| `io`               | -                                                                                                   |
| `isotope`          | -                                                                                                   |
| `manegarm`         | -                                                                                                   |
| `material-vivid`   | -                                                                                                   |
| `miramare`         | -                                                                                                   |
| `monokai`          | -                                                                                                   |
| `oceanic-next`     | -                                                                                                   |
| `old-hope`         | -                                                                                                   |
| `outrun-dark`      | -                                                                                                   |
| `spaceduck`        | -                                                                                                   |
| `stella`           | -                                                                                                   |
| `summerfruit-dark` | -                                                                                                   |
| `woodland`         | -                                                                                                   |
| `xcode-dusk`       | -                                                                                                   |


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
