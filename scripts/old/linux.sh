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
    'curl'
)

echo "Installing apt apps"
for app in "${apps[@]}"; do
    echo "Installing ${app}"
    sudo apt install "$app"
done
echo 

declare -a app=(
    'postman'
    'dbeaver-ce'
    'docker'
    'onlyoffice-desktopeditors'
    'vlc'
    'starship'
    'gnome-extension-manager'
    'diff-so-fancy'
    'bitwarden'
    'handbrake'
)

echo "Installing snap apps"
for app in "${app[@]}"; do
    echo "Installing ${app}"
    sudo snap install "$app"
done
echo

echo "Installing yarn"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install yarn -y
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

echo "Installing speedTest"
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest

echo "Installing node"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
nvm install v18.13.0

echo "Installing neovim"
sudo add-apt-repository universe
sudo apt install libfuse2

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage

sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
nvim
echo

echo "Installing Github CLI"
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

echo
sudo apt update
sudo apt install gh

echo

echo "Atom-dark theme"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh)"

echo "Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing Nerdfonts"
cd ~/Downloads
curl -LJO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip -o ~/Downloads/Hack.zip
unzip Hack.zip -d Hack
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
nvm install -tls

echo "Restart the pc to see the changes"

echo "Make zsh the default shell"
chsh -s $(which zsh)  
