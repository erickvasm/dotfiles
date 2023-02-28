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
    'openjdk-17-jdk'
    'python3'
    'pip'
    'cargo'
    'fzf'
    'exa'
    'bat'
    'go'
    'htop'
    'rust'
    'gradle'
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
    'screenstudio'
    'firefox'
    'google-chrome'
    'microsoft-edge-dev'
    'postman'
    'slack'
    'visual-studio-code'
    'zoom'
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

echo "Installing LunarVim"
LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh)
echo

echo "Installing node"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
nvm install v18.13.0

echo "Installing Nerdfonts"
cd ~/Downloads/
curl -LJO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip
unzip Hack.zip -d Hack

echo "Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Copy and move the nvim folder to .config"
mkdir ~/.config/nvim
cp ~/Projects/dotfiles/nvim/init.vim ~/.config/nvim

echo

# move atom-one-dark to shemes
echo "Moving atom-one-dark to shemes"
mkdir ~/shemes
sudo cp -R ~/Projects/dotfiles/atom-one-dark-terminal ~/shemes/

echo "Copy and move the bash file to the home directory"
if [ -f ~/.bashrc ]; then
    rm ~/.bashrc    
fi
if [ -f ~/.bash_profile ]; then
    rm ~/.bash_profile    
fi
if [ -f ~/.bash_prompt ]; then
    rm ~/.bash_prompt
fi

cp  ~/Projects/dotfiles/bash/.bash_profile ~
cp  ~/Projects/dotfiles/linux/.bashrc ~
cp  ~/Projects/dotfiles/bash/.bash_prompt ~

echo "Move gitignore"
cp / ~/Projects/dotfiles/git/.gitconfig ~
cp  ~/Projects/dotfiles/git/.gitignore_global ~
 

# CLEANUP
brew cleanup
