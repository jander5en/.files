# .files
alle mine .config og home/. files

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
sudo apt install lightdm i3 i3status i3lock dmenu fonts-jetbrains-mono

rm -r /home/${USER}/.config/i3
ln -s /home/${USER}/.files/i3 /home/${USER}/.config/i3
ln -s /home/${USER}/.files/i3status /home/${USER}/.config/i3status
ln -s /home/${USER}/.files/i3/gtk.css /home/${USER}/.config/gtk-3.0/gtk.css

sudo apt remove ubuntu-desktop gnome-shell gdm3
sudo apt autoremove

feh --bg-scale /home/${USER}/.files/i3/gnu.png

## Install og setup for foretrukne apper
### bytt ut filemanager til thunar
sudo apt remove nautilus
sudo apt install feh picom alacritty thunar maim

ln -s /home/${USER}/.files/i3 /home/${USER}/.config/i3
ln -s /home/${USER}/.files/picom /home/${USER}/.config/picom

### Installere vivaldi
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | sudo dd of=/usr/share/keyrings/vivaldi-browser.gpg
echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" | sudo dd of=/etc/apt/sources.list.d/vivaldi-archive.list
sudo apt update
sudo apt install vivaldi-stable

optional: remove firefox
sudo apt remove firefox

### NVIM

ln -s /home/${USER}/.files/nvim /home/${USER}/.config/nvim
sudo apt install xclip

### ZSH
sudo apt install fzf
/\*Alternativt hvis apt er for gammel:
git clone --depth 1 https://github.com/junegunn/fzf.git /home/${USER}/.fzf
/home/${USER}/.fzf/install
\*/
ln -s /home/${USER}/.files/zsh/.zshrc /home/${USER}/.zshrc
mkdir /home/${USER}/.config/bat
mkdir /home/${USER}/.config/bat/themes
ln -s /home/${USER}/.files/zsh/mocha.tmTheme /home/${USER}/.config/bat/themes/mocha.tmTheme
