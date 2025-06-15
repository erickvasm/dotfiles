#!/bin/bash
set -euo pipefail 

# Cargar funciones y variables
source ./utils.sh

log_info "Instalando GitHub CLI"
type -p curl >/dev/null || sudo apt update && sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y || _e "Error installing Github CLI"

log_info "Instalando volta"
curl https://get.volta.sh | bash
source ~/.bashrc
volta install node || _e "Error installing node"

log_info "Instalando neovim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && mv nvim-linux64.tar.gz ~/Downloads/
sudo rm -rf /opt/nvim
sudo tar -C /opt -xvzf ~/Downloads/nvim-linux64.tar.gz || _e "Error extracting Neovim"
if [ -d /opt/nvim-linux64 ]; then
    export PATH="$PATH:/opt/nvim-linux64/bin"
else
  _e "Extraction failed or nvim-linux64 directory not found"
  exit 1
fi
    
log_info "Instalando eza"    
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

log_info "Instalando starship"
curl -sS https://starship.rs/install.sh | shv
