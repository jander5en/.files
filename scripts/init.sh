#!/bin/bash

sudo apt-get update -y 
sudo apt-get upgrade -y 

sudo apt-get install -y build-essential
sudo apt-get install -y git curl make cmake vim htop tree openssh-server net-tools rasi \
  flatpak dmenu fonts-jetbrains-mono zsh feh alacritty thunar maim flatpak xclip nvim tmux \
  rfkill

## Setup notes ubuntu m/x11:
#lag logikk som leser systemet og gjør riktige innstillinger ettersom hva som er der. ubuntu/arch/fedora/mac etc

if [ -d "/home/${USER}/.config" ]; then 
    echo ".config exists"
else
    echo "creating .config"
    mkdir /home/${USER}/.config
fi


## lightdm og i3

//get latest stable i3 version
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2025.12.14_all.deb keyring.deb SHA256:2c816fbd12ea4d84811818aed0ce3a5da589be1afa30833eb32abc1e4fe6349e
sudo apt install ./keyring.deb
echo "deb [signed-by=/usr/share/keyrings/sur5r-keyring.gpg] http://debian.sur5r.net/i3/ $(grep '^VERSION_CODENAME=' /etc/os-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
rm keyring.deb

sudo apt update -y 
sudo apt install -y lightdm i3 i3status i3lock rofi ufw fail2ban apparmor apparmor-utils
rm -r /home/${USER}/.config/i3
ln -s /home/${USER}/.files/i3 /home/${USER}/.config/i3
ln -s /home/${USER}/.files/i3/gtk.css /home/${USER}/.config/gtk-3.0/gtk.css

sudo apt remove -y ubuntu-desktop gnome-shell gdm3
sudo apt autoremove -y


## Install og setup for foretrukne apper

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.mozilla.firefox -y
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub com.vivaldi.Vivaldi -y
flatpak install flathub org.mozilla.Thunderbird -y
flatpak install flathub org.libreoffice.LibreOffice -y
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install flathub org.videolan.VLC -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub io.podman_desktop.PodmanDesktop -y

sudo apt remove -y nautilus

## tmux
rm /home/${USER}/.tmux.conf
ln -s .files/tmux/.tmux.conf /home/${USER}/.tmux.conf

### NVIM

rm -r /home/${USER}/.config/nvim
ln -s /home/${USER}/.files/nvim /home/${USER}/.config/nvim

### FZF
git clone --depth 1 https://github.com/junegunn/fzf.git /home/${USER}/.fzf
/home/${USER}/.fzf/install

### ZSH
rm /home/${USER}/.zshrc
ln -s /home/${USER}/.files/zsh/.zshrc /home/${USER}/.zshrc
chsh -s $(which zsh)

## Security settings:



sudo reboot
