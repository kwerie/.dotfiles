### .dotfiles

This repo houses all of the dotfiles needed for terminal configuration (aliases, nvim config etc.).

## Prerequisites

1. Git
    1. Git can be installed with apt (sudo apt install git -y)
2. (GNU) stow
    1. GNU Stow can be installed with apt (sudo apt install stow -y)


## Installation
Update your repositories (e.g. sudo apt update)
Clone this repository to your `$HOME` directory
```
cd .dotfiles
stow .
```


By default, i3(wm) installs dmenu. The downsight to this is that you can't customize it.
On Debian and Debian-based distros, you can install the dependencies using the following command:

```
sudo apt-get install libx11-dev libxft-dev libxinerama-dev build-essential sharutils
```

Optionally, you can install `dwm` (window manager):
```
git clone https://git.suckless.org/dwm
cd dwm/
make
sudo make install
```
