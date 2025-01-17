#!/usr/bin/env bash

# Configuración inicial
set -euo pipefail  # Detener el script en caso de errores no manejados

# Definir colores
RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NORMAL='\033[0m'

# Funciones auxiliares
log_info() { echo -e "${GREEN}[INFO]${NORMAL} $1"; }
log_warn() { echo -e "${PURPLE}[WARN]${NORMAL} $1"; }
log_error() { echo -e "${RED}[ERROR]${NORMAL} $1"; exit 1; }
confirm() { read -rp "🤔 $1 [y/N]: " response; [[ "$response" =~ ^[Yy]$ ]]; }
command_exists() { command -v "$1" &>/dev/null; }

# Manejo de errores global
trap 'log_error "Ha ocurrido un error inesperado. Abortando."' ERR

# Variables globales
DEFAULT_DOTFILES_DIR="$HOME/.dotfiles"
DEFAULT_FONTS_DIR="$HOME/.fonts"

# Función principal
dotfiles_install() {
    log_info "🚀 Iniciando la instalación de dotfiles"

    # Verificar ubicación actual del directorio de dotfiles
    if [[ -d "$DEFAULT_DOTFILES_DIR" ]]; then
        log_info "El directorio de dotfiles ya está en $DEFAULT_DOTFILES_DIR. No se requiere acción."
    else
        log_warn "El directorio de dotfiles no está en $DEFAULT_DOTFILES_DIR."

        # Buscar el directorio de dotfiles en la máquina
        current_dir=$(find ~ -maxdepth 2 -type d -name "dotfiles" 2>/dev/null | head -n 1)

        if [[ -n "$current_dir" ]]; then
            log_info "Se encontró el directorio actual de dotfiles en: $current_dir"
            log_info "Moviendo y renombrando el directorio a $DEFAULT_DOTFILES_DIR..."
            mv "$current_dir" "$DEFAULT_DOTFILES_DIR"
        else
            log_error "No se encontró un directorio de dotfiles. Por favor clónalo manualmente."
        fi
    fi

    # Cambiar al directorio de dotfiles
    cd "$DEFAULT_DOTFILES_DIR" || log_error "No se puede acceder a $DEFAULT_DOTFILES_DIR."

    # Detectar sistema operativo e iniciar instalación específica
    case "$(uname)" in
        "Darwin") dotfiles_install_mac ;;
        "Linux") dotfiles_install_linux ;;
        *) log_error "Sistema operativo no soportado." ;;
    esac

    log_info "🎉 ¡Dotfiles instalados correctamente! Por favor reinicia tu terminal."
}

# Instalación específica para macOS
dotfiles_install_mac() {
    log_info "Detectado macOS. Configurando entorno..."

    # Cambiar a bash como shell por defecto
    chsh -s /bin/bash

    # Instalar Homebrew si no está presente
    if ! command_exists brew; then
        log_info "Instalando Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Actualizar e instalar aplicaciones con Homebrew
    log_info "Actualizando e instalando aplicaciones con Homebrew"
    brew update && brew upgrade
    brew bundle --file="$dotfiles_dir/os/mac/brew/Brewfile" --force || log_error "Error al instalar apps con Homebrew."

    log_info "Installing mac cleaner"
    curl -o ~/Downloads/AppCleaner.dmg "https://www.freemacsoft.net/downloads/AppCleaner_3.5.zip"

    log_info "Developer folder"
    mkdir ~/Developer

    # Configurar fuentes
    dotfiles_install_fonts

    # Configuración específica del sistema
    log_info "Aplicando configuraciones específicas para macOS"
    chmod +x "$dotfiles_dir/os/mac/macos.sh"
    "$dotfiles_dir/os/mac/macos.sh" || log_error "Error al aplicar configuraciones macOS."

    log_info "Se debe copiar el plist de hotkeys en el directorio ~/Library/Preferences/ y reiniciar el sistema"

    # Configurar enlaces simbólicos
    dotfiles_setup_symlinks "mac"
}

# Instalación específica para Linux
dotfiles_install_linux() {
    log_info "Detectado Linux. Configurando entorno..."

    # Actualizar sistema y reparar dependencias rotas
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y --fix-broken

    # Instalar aplicaciones con apt
    log_info "Instalando aplicaciones con apt"
    apps=("git" "zsh" "curl" "snapd" "vim" "htop" "zsh" "python3" "python3-pip" "fzf" "python3-pip" "gnome-tweaks")
    for app in "${apps[@]}"; do
        sudo apt-get install -y "$app" || log_warn "No se pudo instalar $app"
    done

    wget -O ~/Downloads/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb || { sudo apt-get install -f -y; sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb; } || _e "Error installing Google Chrome"

    log_info "Instalando Otras apps..."
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo apt update
    sudo apt install wezterm

    curl https://get.volta.sh | bash
    source ~/.bashrc
    volta install node || _e "Error installing node"

    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && mv nvim-linux64.tar.gz ~/Downloads/
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xvzf ~/Downloads/nvim-linux64.tar.gz || _e "Error extracting Neovim"
    if [ -d /opt/nvim-linux64 ]; then
        export PATH="$PATH:/opt/nvim-linux64/bin"
    else
        _e "Extraction failed or nvim-linux64 directory not found"
        exit 1
    fi
    
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza

    type -p curl >/dev/null || sudo apt update && sudo apt install curl -y
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y || _e "Error installing Github CLI"

    if command_exists snap; then
        snap_apps=("onlyoffice-desktopeditors" "diff-so-fancy" "intellij-idea-ultimate --classic" "code --classic")
        for app in "${snap_apps[@]}"; do
            sudo snap install "$app" || log_warn "No se pudo instalar $app"
        done
    else
        log_warn "Snap no está instalado. Saltando instalación de aplicaciones snap."
    fi


    log_info "Instalando starship"
    curl -sS https://starship.rs/install.sh | shv

    # Configurar fuentes
    dotfiles_install_fonts

    # Configurar enlaces simbólicos
    dotfiles_setup_symlinks "linux"

    xmodmap ~/.Xmodmap
    echo "xmodmap ~/.Xmodmap" >> ~/.xprofile

    # Make zsh the default shell
    chsh -s $(which zsh)

    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh || _e "Error installing zim"

    zimfw install
}

# Instalación de fuentes
dotfiles_install_fonts() {
    log_info "Instalando fuentes personalizadas..."

    mkdir -p "$DEFAULT_FONTS_DIR"

    gh auth login

    gh repo clone erickvasm/DankMono "$DEFAULT_FONTS_DIR" || log_warn "No se pudo clonar el repositorio de fuentes."

    curl -LJO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip
    unzip -o Hack.zip -d "$DEFAULT_FONTS_DIR/Hack"
    rm Hack.zip
}

# Configurar enlaces simbólicos
dotfiles_setup_symlinks() {
    local platform="$1"
    log_info "Configurando enlaces simbólicos para $platform..."
    chmod +x "$dotfiles_dir/symlinks/symlink-$platform.sh"
    "$dotfiles_dir/symlinks/symlink-$platform.sh" || log_error "Error al configurar enlaces simbólicos."
}

# Ejecutar instalación
dotfiles_install
