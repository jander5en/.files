#!/bin/bash


## Install og setup for foretrukne apper

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.mozilla.firefox
flatpak install flathub org.gimp.GIMP
flatpak install flathub com.vivaldi.Vivaldi
flatpak install flathub org.mozilla.Thunderbird

sudo apt install feh alacritty thunar maim xclip

sudo apt remove nautilus

ln -s /home/${USER}/.files/i3 /home/${USER}/.config/i3


## tmux
sudo apt install tmux
rm /home/${USER}/.tmux.conf
ln -s .files/tmux/.tmux.conf .tmux.conf

### NVIM

ln -s /home/${USER}/.files/nvim /home/${USER}/.config/nvim

### FZF
git clone --depth 1 https://github.com/junegunn/fzf.git /home/${USER}/.fzf
/home/${USER}/.fzf/install

### ZSH
ln -s /home/${USER}/.files/zsh/.zshrc /home/${USER}/.zshrc
