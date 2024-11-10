#!/usr/bin/env bash

# Define colors
red='\033[0;31m'
green='\033[0;32m'
purple='\033[0;35m'
normal='\033[0m'

# functions
_w() { echo -e "${1-}"; }
_a() { _w " > $1"; }
_e() { _w "${red}$1${normal}"; }
_s() { _w "${green}$1${normal}"; }
_q() { read -rp "🤔 $1: " "$2"; }
current_timestamp() { date +%s; }
command_exists() { type "$1" >/dev/null 2>&1; }


# Main function for installing dotfiles
install_dotfiles() {
    _w "  ┌────────────────────────────────────┐"
    _w "~ │ 🚀 ${green}dotfiles${normal} installer! │ ~"
    _w "  └────────────────────────────────────┘"
    _w
    _q "The dotfiles will be installed in (default ~/.dotfiles): " dotfiles_dir
    dotfiles_dir=${dotfiles_dir:-~/.dotfiles}
    fonts_dir="$HOME/.fonts"
    repo_dir="$HOME/fonts-personal"

    # Rename current directory to ~/.dotfiles
    mv ~/dotfiles "$dotfiles_dir" || { _e "Cannot rename directory to $dotfiles_dir"; return 1; }

    # Change to dotfiles directory
    cd "$dotfiles_dir" || { _e "Cannot change directory to $dotfiles_dir"; return 1; }

    if [[ "$(uname)" == "Darwin" ]]; then
        install_mac_config
    elif [[ "$(uname)" == "Linux" ]]; then
        install_linux_config
    else
        _e "Unsupported OS!"
        return 1
    fi

    _s "🎉 dotfiles installed correctly! 🎉"
    _s "Please, restart your terminal to see the changes"
}

# Function to install dotfiles and configurations for macOS
install_mac_config() {
    _s "Mac detected. Using Mac config..."

    #Make bash the default shell
    chsh -s /bin/bash

    # SETUP
    # Install Homebrew if not installed
    if ! command_exists brew; then
        _s "Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    _s "Upgrading Homebrew"
    brew update && brew upgrade

    # INSTALL BREW APPS
    _s "Installing brew apps"
    touch ~/.hushlogin
    brew bundle --file="$dotfiles_dir/mac/brew/Brewfile" --force

    # INSTALL PYTHON MODULES
    _s "Installing python modules"
    pip install -r "$dotfiles_dir/langs/python/pip.txt" || _e "Error installing python modules"

    _s "Installing mac cleaner"
    curl -o ~/Downloads/AppCleaner.dmg "https://www.freemacsoft.net/downloads/AppCleaner_3.5.zip"

    gh auth login

    _s "Developer folder"
    mkdir Developer

      _s "Installing private font"
    # Verificar si el directorio de fuentes no existe. Si no existe, crearlo.
    if [ ! -d "$fonts_dir" ]; then
        mkdir -p "$fonts_dir"
    fi
    # Verificar si el directorio del repositorio no existe. Si no existe, crearlo.
    if [ ! -d "$repo_dir" ]; then
        mkdir -p "$repo_dir"
    fi
    gh repo clone erickvasm/font "$repo_dir" || _e "Error cloning private font repository"
    curl -LJO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip
    mv "Hack.zip" "$fonts_dir/Hack.zip" || _e "Error moving Hack.zip to $fonts_dir"
    unzip -o "$fonts_dir/Hack.zip" -d "$fonts_dir/Hack" || _e "Error extracting Hack.zip"
    rm "$fonts_dir/Hack.zip" || _e "Error removing Hack.zip"

    _s "Setup mac config"
    chmod +x "$dotfiles_dir/os/mac/macos.sh"
    "$dotfiles_dir/os/mac/macos.sh" || _e "Error setting up mac config"

    _s "Setup the symlinks"
    # Fix potential Windows line endings
    sed -i 's/\r$//' "$dotfiles_dir/symlinks/symlink-mac.sh"
    chmod +x "$dotfiles_dir/symlinks/symlink-mac.sh"
    "$dotfiles_dir/symlinks/symlink-mac.sh" || _e "Error setting up symlinks"
    

    # CLEANUP
    brew cleanup || _e "Error cleaning up"

    _a "Remember to install the following manually:"
    _a " - Iterm2 config"
    _a " - Rectangle"
}


# Function to install dotfiles and configurations for Linux
install_linux_config() {
    _s "Linux detected. Using Linux config..."

    # Updating apt and upgrading packages
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y --fix-broken
    sudo rm /etc/apt/preferences.d/nosnap.pref

    # Installing apt apps
    _s "Installing apt apps"
    sudo apt-get -y install $(<"$dotfiles_dir/os/linux/apt/apt-installed.txt") || { sudo apt-get install -f -y; sudo apt-get -y install $(<"$dotfiles_dir/os/linux/apt/apt-installed.txt"); } || _e "Error installing apt apps"

    # Installing snap app
    _s "Installing snap app"
    xargs -L 1 sudo snap install < "$dotfiles_dir/os/linux/snap/snap-installed.txt"

    # Installing chrome
    _s "Installing Google Chrome"
    wget -O ~/Downloads/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb || { sudo apt-get install -f -y; sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb; } || _e "Error installing Google Chrome"

    # Hyper.js
    _s "Installing hyper.js"
   wget -O ~/Downloads/hyper.deb https://releases.hyper.is/download/deb && sudo dpkg -i ~/Downloads/hyper.deb || { sudo apt-get install -f -y; sudo dpkg -i ~/Downloads/hyper.deb; } || echo "Error installing Hyper"

    # INSTALL PYTHON MODULES
    _s "Installing python modules"
    pip3 install -r "$dotfiles_dir/langs/python/pip.txt" || _e "Error installing python modules"

    _s "Installing node"
    curl https://get.volta.sh | bash
    source ~/.bashrc
    volta install node || _e "Error installing node"
   
    # INSTALL node modules
    _s "Installing node modules"
    xargs -I_ npm install -g "_" < "$dotfiles_dir/langs/javascript/global_module.txt" || _e "Error installing node modules"

    _s "Delete bashrc"
    if [ -f ~/.bashrc ]; then
       rm ~/.bashrc || _e "Error delete bashrc"
    fi    

    _s "Setup the symlinks"
   sed -i 's/\r$//' "$dotfiles_dir/symlinks/symlink-mac.sh"
   chmod +x "$dotfiles_dir/symlinks/symlink-linux.sh"
   "$dotfiles_dir/symlinks/symlink-linux.sh" || _e "Error setting up symlinks"

    # Descargar e instalar Neovim
    _e "Installing neovim"
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && mv nvim-linux64.tar.gz ~/Downloads/
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xvzf ~/Downloads/nvim-linux64.tar.gz || _e "Error extracting Neovim"
    if [ -d /opt/nvim-linux64 ]; then
        # Agregar Neovim al PATH
        export PATH="$PATH:/opt/nvim-linux64/bin"
    else
        _e "Extraction failed or nvim-linux64 directory not found"
        exit 1
    fi

    _s "Installing Github CLI"
    type -p curl >/dev/null || sudo apt update && sudo apt install curl -y
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y || _e "Error installing Github CLI"

    gh auth login

    _s "Installing zsh config"
    if [ -f ~/.zshrc ]; then
        mv ~/.zshrc ~/.zshrc.bak || _e "Error backing up existing .zshrc"
    fi

     _s "Installing private font"
   # Verificar si el directorio de fuentes no existe. Si no existe, crearlo.
    if [ ! -d "$fonts_dir" ]; then
        mkdir -p "$fonts_dir"
    fi
    # Verificar si el directorio del repositorio no existe. Si no existe, crearlo.
    if [ ! -d "$repo_dir" ]; then
        mkdir -p "$repo_dir"
    fi

    gh repo clone erickvasm/font "$repo_dir" || _e "Error cloning private font repository"
    curl -LJO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip
    mv "Hack.zip" "$fonts_dir/Hack.zip" || _e "Error moving Hack.zip to $fonts_dir"
    unzip -o "$fonts_dir/Hack.zip" -d "$fonts_dir/Hack" || _e "Error extracting Hack.zip"
    rm "$fonts_dir/Hack.zip" || _e "Error removing Hack.zip"

    # Make zsh the default shell
    _s "Changing default shell to zsh"
    chsh -s $(which zsh)

    _s "Installing zim"
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh || _e "Error installing zim"

    zimfw install
}



# Call the main function
install_dotfiles


