# .files
alle mine .config og home/. files

//COnsider the other tmux and workspace setup for tmux and i3 here: https://7rishi.io/articles/ubuntu_setup/
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install git curl make cmake vim htop tree openssh-server net-tools rasi flatpak


## Setup notes ubuntu m/x11:
//lag logikk som leser systemet og gjør riktige innstillinger ettersom hva som er der. ubuntu/arch/fedora/mac etc

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

sudo apt update
sudo apt install lightdm i3 i3status i3lock dmenu fonts-jetbrains-mono zsh

rm -r /home/${USER}/.config/i3
ln -s /home/${USER}/.files/i3 /home/${USER}/.config/i3
ln -s /home/${USER}/.files/i3status /home/${USER}/.config/i3status
ln -s /home/${USER}/.files/i3/gtk.css /home/${USER}/.config/gtk-3.0/gtk.css

sudo apt remove ubuntu-desktop gnome-shell gdm3
sudo apt autoremove


## Install og setup for foretrukne apper

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.mozilla.firefox
flatpak install flathub org.gimp.GIMP
flatpak install flathub com.vivaldi.Vivaldi
flatpak install flathub org.mozilla.Thunderbird

sudo apt install feh alacritty thunar maim xclip

sudo reboot
sudo apt remove nautilus
sudo apt install feh picom alacritty thunar maim

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

\*/
### ZSH
ln -s /home/${USER}/.files/zsh/.zshrc /home/${USER}/.zshrc
