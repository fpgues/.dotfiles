#!/bin/bash

echo " "
echo "		___   __  ____________  "
echo "	   /   | / / / /_  __/ __ \ "
echo "	  / /| |/ / / / / / / / / / "
echo "	 / ___ / /_/ / / / / /_/ / "
echo "	/_/  |_\____/ /_/  \____/ "
echo " "


###Apt's
sudo apt -y install curl git htop gparted tilix neofetch geany flameshot nautilus rofi picom python3-pip pavucontrol gcc blueman pulsemixer ranger nitrogen vim neovim wget lxappearance gimp build-essential libpam0g-dev libxcb-xkb-dev mlocate mpv pamixer shotwell xclip zathura-pdf-poppler fzf w3m-img apt-show-versions fonts-font-awesome awesome awesome-extra meson asciidoc font-manager libncurses5-dev linux-headers-amd64 knotes qimgv libevdev2 libpcre3-dev calc gnome-boxes xscreensaver parcellite cava


### Apps Snaps
sudo apt update

sudo apt install snapd

sudo snap install core

sudo snap install snap-store

sudo snap install discord-canary spotify


### Install zsh & oh-my-zsh!
sudo apt install zsh && zsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


## Fonts/icons/themes
rm ~/.zshrc

ln -s ~/.dotfiles/.zshrc ~/.zshrc

ln -s ~/.dotfiles/.gitconfig ~/ && ln -s ~/.dotfiles/.config/* ~/.config/

cd ~/.local/share/ && sudo mkdir rofi

sudo ln -s ~/.dotfiles/.config/rofi/themes/ ~/.local/share/rofi/

sudo rm -r /usr/share/awesome/themes/

sudo ln -s ~/.dotfiles/.config/awesome/themes/ /usr/share/awesome/

sudo ln -s ~/.dotfiles/.config/lx-themes/fonts ~/.fonts

sudo ln -s ~/.dotfiles/.config/lx-themes/cursor/* /usr/share/icons

sudo ln -s ~/.dotfiles/.config/lx-themes/icons/* /usr/share/icons

sudo ln -s ~/.dotfiles/.config/lx-themes/themes/* /usr/share/themes


### PARA RODAR O :PlugInstall no NVIM

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#Abra o NVIM e execute ":PlugInstall"

### Picom (dependências caso necessário)

sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev


#Alacritty
sudo apt -y install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source $HOME/.cargo/env

sudo apt -y install cargo

cargo install alacritty

git clone https://github.com/alacritty/alacritty.git

cd alacritty

sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg && sudo desktop-file-install extra/linux/Alacritty.desktop && sudo update-desktop-database

sudo cp $HOME/.cargo/bin/alacritty /usr/local/bin

mkdir -p ${ZDOTDIR:-~}/.zsh_functions

echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc

cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty


### Install Ly Manager
sudo snap install zig --beta --classic

git clone --recurse-submodules https://github.com/fairyglade/ly

cd ly

sudo snap run zig build

sudo snap run zig build installsystemd

sudo systemctl disable lightdm.service

sudo systemctl enable ly.service


## Reload fonts
fc-cache -f -v
