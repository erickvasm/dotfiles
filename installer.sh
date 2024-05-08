#!/usr/bin/env bash

red='\033[0;31m'
green='\033[0;32m'
purple='\033[0;35m'
normal='\033[0m'

_w() {
	local -r text="${1-}"
	echo -e "$text"
}
_a() { _w " > $1"; }
_e() { _a "${red}$1${normal}"; }
_s() { _a "${green}$1${normal}"; }
_q() { read -rp "🤔 $1: " "$2"; }

current_timestamp() { date +%s; }

command_exists() {
	type "$1" >/dev/null 2>&1
}

_w "  ┌────────────────────────────────────┐"
_w "~ │ 🚀 ${green}dotfiles${normal} installer! │ ~"
_w "  └────────────────────────────────────┘"
_w
_q "The dotfiles will installed in (default ~/.dotfiles)" 

cd ~/.dotfiles


if [[ `uname` == "Darwin"   ]]; then
	_a "Mac detected. Using Mac config..."
  	#Make bash the default shell
	chsh -s /bin/bash

	# SETUP
	which -s brew
	if [[ $? != 0 ]] ; then
		_a "Installing Homebrew"
		/usr/bin/bash -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	_a "Upgrading Homebrew"
	brew upgrade
	_a "Updating Homebrew"
	brew update 

	# INSTALL BREW APPS
	_a "Installing brew apps"
	touch ~/.hushlogin
	brew bundle --file=~/.dotfiles/mac/brew/Brewfile --force

	# INSTALL node modules
	_a "Installing node modules"
	xargs -I_ npm install -g "_" < "~/.dotfiles/langs/javascript/global_module.txt"

	# INSTALL PYTHON MODULES
	_a "Installing python modules"
	pip install -r "~/.dotfiles/langs/python/pip.txt"

	a_ "Installing mac cleaner"
	curl -o ~/Downloads/AppCleaner.dmg "https://www.freemacsoft.net/downloads/AppCleaner_3.5.zip"

	a_ "Installing Nerdfonts"
	cd ~/Downloads/
	curl -LJO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip
	unzip Hack.zip -d Hack

	_s "Visual Studio code symlink.sh"
	ln -s ~/.dotfiles/editors/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
	ln -s ~/.dotfiles/editors/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
	ln -s ~/.dotfiles/editors/vscode/snippets/ ~/Library/Application\ Support/Code/User/snippets

	_a "Bash aliases"
	ln -s ~/.dotfiles/os/mac/.bash_aliases ~/.bash_aliases

	_a "Installing private font"
	mkdir ~/.fonts
	cd ~/.fonts && git clone git@github.com:erickvasm/font.git

	_a "Setup mac config"
	chmod +x ~/.dotfiles/os/mac/macos.sh
	~/.dotfiles/os/mac/macos.sh

	a_ "Setup the symlinks"
    chmod +x ./symlinks/symlink.sh # no se puede ejecutar
    ./symlinks/symlink.sh

	# CLEANUP
	brew cleanup

	_a "Remember to install the following manually:"
	_a " - Iterm2 config"
	_a "Rectangle"
fi

if [[ `uname` == "Linux"   ]]; then
  _a "Linux detected. Using Linux config..."

	_a "Updating apt and upgrading packages"
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt autoremove
	sudo apt-add repository universe

	_a "Installing apt apps"
	xargs sudo apt-get -y install < ~/.dotfiles/os/linux/apt/apt-installed.txt

	_a "Installing snap apps"
	xargs sudo snap install < ~/.dotfiles/os/linux/snap/snap-installed.txt

	_a "Installing other apps"
	sudo snap install code --classic
	sudo snap install intellij-idea-community --classic

	_a "Installing chrome"
	cd ~/Downloads
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/Downloads
	sudo dpkg -i google-chrome-stable_current_amd64.deb

	# INSTALL node modules - TODO: NO FUNCIONA
	_a "Installing node modules"
	xargs -I_ npm install -g "_" < "~/.dotfiles/langs/javascript/global_module.txt"

	# INSTALL PYTHON MODULES - NO FUNCIONA
	_a "Installing python modules"
	pip install -r "~/.dotfiles/langs/python/pip.txt"

	_a "Installing speedTest"
	curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
	sudo apt-get install speedtest

	_a "Installing node"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
	source ~/.bashrc
	nvm install --lts

	_a "Installing neovim" # no funciona
	cd ~/Dowloads
	sudo add-apt-repository universe
	sudo apt install libfuse2
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	./nvim.appimage
	sudo mv squashfs-root /
	sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
	nvim

	_a "Installing Github CLI"
	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
	sudo apt update
	sudo apt install gh

	_a "Installing Nerdfonts"
	cd ~/Downloads
	curl -LJO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip -o ~/Downloads/Hack.zip
	unzip Hack.zip -d Hack

	_a "Installing plugins"
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlightin

	_a "Installing zsh config"
	if [ -f ~/.zshrc ]; then
		rm ~/.zshrc
	fi
	ln -s ~/.dotfiles/shell/zsh/.zshrc ~/.zshrc

	_a "Bash aliases"
	ln -s ~/.dotfiles/os/linux/.bash_aliases ~/.bash_aliases

	_a "Installing node for zsh"\
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
	source ~/.zshrc
	nvm install --lts

	_a "Installing private font"
	mkdir ~/.fonts
	cd ~/.fonts && git clone git@github.com:erickvasm/font.git

	_a "Installing Terminal Theme"
	mkdir ~/.terminal-themes
	cd ~/.terminal-themes
	sudo apt-get install dconf-cli
	git clone https://github.com/dracula/gnome-terminal
	cd gnome-terminal
	./install.sh
	
	_a "Xmodmap"
	ln -s ~/.dotfiles/os/linux/.Xmodmap ~/.Xmodmap

	a_ "Setup the symlinks"
    chmod +x ./symlinks/symlink.sh # no se puede ejecutar
    ./symlinks/symlink.sh

	_a "Installing zsh"
	sudo apt install zsh

	_a "Installing oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	_a "Make zsh the default shell"
	chsh -s $(which zsh)  	
fi

_a "🎉 dotfiles installed correctly! 🎉"
_a "Please, restart your terminal to see the changes"