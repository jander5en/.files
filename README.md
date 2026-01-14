# .files
alle mine .config og home/. files



## Setup notes ubuntu m/x11:
//lag logikk som leser systemet og gjør riktige innstillinger ettersom hva som er der. ubuntu/arch/fedora/mac etc
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
