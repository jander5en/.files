# .files
alle mine .config og home/. files



## Setup notes ubuntu m/x11:
//lag logikk som leser systemet og gjør riktige innstillinger ettersom hva som er der. ubuntu/arch/fedora/mac etc

## Install og setup for foretrukne apper
### bytt ut filemanager til thunar
sudo apt remove nautilus
sudo apt install thunar

### Installere vivaldi
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | sudo dd of=/usr/share/keyrings/vivaldi-browser.gpg
echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" | sudo dd of=/etc/apt/sources.list.d/vivaldi-archive.list
sudo apt update
sudo apt install vivaldi-stable

optional: remove firefox
sudo apt remove firefox

### NVIM

ln -s ~/.files/nvim ~/.config/nvim
sudo apt install xclip

### ZSH
sudo apt install fzf
/\*Alternativt hvis apt er for gammel:
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
\*/
ln -s ~/.files/zsh/.zshrc ~/.zshrc
mkdir ~/.config/bat
mkdir ~/.config/bat/themes
ln -s ~/.files/zsh/mocha.tmTheme ~/.config/bat/themes/mocha.tmTheme
