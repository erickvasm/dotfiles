#!/bin/bash

#Make bash the default shell
chsh -s /bin/bash

# SETUP
which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Homebrew"
    /usr/bin/bash -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "Upgrading Homebrew"
brew upgrade
echo "Updating Homebrew"
brew update

echo 

# INSTALL BREW APPS
declare -a apps=(
    'git'
    'openjdk-21-jdk'
    'python3'
    'pip'
    'cargo'
    'fzf'
    'exa'
    'bat'
    'go'
    'htop'
    'gradle'
    'handbrake'
    'gh'
)
echo "Installing brew apps"
for app in "${apps[@]}"; do
    echo "      Installing ${app}"
    brew install "$app"
done

echo 


# INSTALL BREW CASK APPS
declare -a cask_apps=(
    'dbeaver-community'
    'iterm2'
    'docker'
    'rectangle'
    'google-chrome'
    'postman'
    'slack'
    'visual-studio-code'
    'jetbrains-toolbox'
)
echo "Installing brew cask apps"
for cask_app in "${cask_apps[@]}"; do
    echo "      Installing ${cask_app}"
    brew install --cask "$cask_app"
done

echo 

echo "Installing mac cleaner"
curl -o ~/Downloads/AppCleaner.dmg "https://www.freemacsoft.net/downloads/AppCleaner_3.5.zip"
echo

echo "Installing speedTest"
brew tap teamookla/speedtest
brew update
brew uninstall speedtest --force
brew uninstall speedtest-cli --force
brew install speedtest --force
echo

echo "Installing Neovim"
brew install neovim

echo "Installing node"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
nvm install --lts

echo "Installing Nerdfonts"
cd ~/Downloads/
curl -LJO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip
unzip Hack.zip -d Hack

echo "Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Copy and move the bash file to the home directory"

# CLEANUP
brew cleanup
