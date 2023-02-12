#!/bin/bash

echo "Updating apt and upgrading packages"
sudo apt-get update
sudo apt-get upgrade
sudo apt autoremove
echo 

sudo apt-add repository universe

declare -a apps=(
    'git'
    'openjdk-17-jdk'
    'python3'
    'pip'
    'cargo'
    'fzf'
    'exa'
    'gnome-tweaks'
)

echo "Installing apt apps"
for app in "${apps[@]}"; do
    echo "Installing ${app}"
    sudo apt install "$app"
done
echo 

declare -a app=(
    'postman'
    'zoom'
    'dbeaver-ce'
    'docker'
    'onlyoffice-desktopeditors'
    'vlc'
    'starship'
    'gnome-extension-manager'
)

echo "Installing snap apps"
for app in "${app[@]}"; do
    echo "Installing ${app}"
    sudo snap install "$app"
done
echo


echo "Installing chrome"
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/Downloads
sudo dpkg -i google-chrome-stable_current_amd64.deb
echo

echo "Installing other apps"
sudo snap install slack --classic
sudo snap install --classic code
sudo snap install intellij-idea-community --classic
echo

echo "Installing node"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
nvm install v18.13.0

echo "Installing neovim"
gem install neovim
npm install -g neovim
echo

echo "Atom-dark theme"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh)"

echo "Copy and move the nvim folder to .config"
mkdir ~/.config/nvim
cp ~/Projects/dotfiles/nvim/init.vim ~/.config/nvim
echo

echo "Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Move the gitconfig file to the home directory"
cp ~/Projects/dotfiles/git/.gitconfig ~
cp ~/Projects/dotfiles/git/.gitignore_global ~

echo "Installing Nerdfonts"
cd ~/Downloads
curl -LJO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip -o ~/Downloads/Hack.zip
unzip Hack.zip -d Hack
echo

echo "Copy and move the bash file to the home directory"
if [ -f ~/.bashrc ]; then
    rm ~/.bashrc    
fi
if [ -f ~/.bash_prompt ]; then
    rm ~/.bash_prompt
fi

cp  ~/Projects/dotfiles/bash/.bash_prompt ~
cp  ~/Projects/dotfiles/linux/.bashrc ~
echo

echo "Installing zsh"
sudo apt install zsh

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlightin

echo "Installing zsh config"
if [ -f ~/.zshrc ]; then
    rm ~/.zshrc
fi
cp ~/Projects/dotfiles/zsh/.zshrc ~
echo

echo "Installing node for zsh"\
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.zshrc
nvm install v18.13.0

echo "Restart the pc to see the changes"

echo "Make zsh the default shell"
chsh -s $(which zsh)  
