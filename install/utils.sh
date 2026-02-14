#!/bin/bash

# Terminar script si hay errores
set -euo pipefail

# Manejo de errores global
trap 'log_error "Interrupción detectada (Ctrl+C). Abortando." && exit 1' SIGINT

# Variables globales
DEFAULT_DOTFILES_DIR="$HOME/.dotfiles"
DEFAULT_FONTS_DIR="$HOME/.fonts"
OS=""

# Manejo de logs
LOG_FILE="$DEFAULT_DOTFILES_DIR/install.log"
: >"$LOG_FILE"
exec > >(tee -a "$LOG_FILE") 2>&1

# Definir colores
RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NORMAL='\033[0m'

# Funciones auxiliares
log_info() { echo -e "${GREEN}[INFO]${NORMAL} $1"; }
log_warn() { echo -e "${PURPLE}[WARN]${NORMAL} $1"; }
log_error() {
  echo -e "${RED}[ERROR]${NORMAL} $1"
  exit 1
}
confirm() {
  read -rp "🤔 $1 [y/N]: " response
  [[ "$response" =~ ^[Yy]$ ]]
}
command_exists() { command -v "$1" &>/dev/null; }

# Hacer ejecutable el script
ejecutable() {
  local script="$1"
  if [[ -f "$script" ]]; then
    chmod +x "$script" || log_error "No se pudo hacer ejecutable el script: $script"
    log_info "Script '$script' ahora es ejecutable."
  else
    log_error "El archivo '$script' no existe."
  fi
}

# Funcion para veritficar que brew esté instalado
check_brew() {
  if ! command_exists brew; then
    log_info "Homebrew no está instalado. Instalando..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    log_info "Homebrew instalado correctamente."
  else
    log_info "Homebrew ya está instalado."
  fi
}

# Funcion para instalar snap si no está instalado
check_snap() {
  if ! command_exists snap; then
    log_info "Snap no está instalado. Instalando..."
    sudo apt update && sudo apt install -y snapd
    log_info "Snap instalado correctamente."
  else
    log_info "Snap ya está instalado."
  fi
}

# Función para verificar si un directorio existe
check_or_create_dir() {
  local dir="$1"
  if [[ ! -d "$dir" ]]; then
    log_info "El directorio '$dir' no existe. Creando..."
    mkdir -p "$dir" || log_error "No se pudo crear el directorio '$dir'."
    log_info "Directorio '$dir' creado correctamente."
  else
    log_info "El directorio '$dir' ya existe."
  fi
}

# identificar el sistema operativo
identify_os() {
  if [[ "$OSTYPE" == "linux"* ]]; then
    OS="Linux"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
  else
    log_error "Sistema operativo no soportado: $OSTYPE"
  fi
  log_info "Sistema operativo identificado: $OS"
}

# Función de animación de carga
with_spinner() {
  local msg="$1"
  shift
  local cmd=("$@")

  log_info "$msg"

  local tmpfile
  tmpfile=$(mktemp)
  local pipefile
  pipefile=$(mktemp -u)
  mkfifo "$pipefile"

  # Proceso lector del pipe
  tee "$tmpfile" <"$pipefile" |
    while IFS= read -r line; do
      echo "$line" >>"$LOG_FILE"

      # Si es línea importante, limpia el spinner antes de imprimirla
      if [[ "$line" == *"[WARN]"* || "$line" == *"[ERROR]"* ]]; then
        printf "\r\033[K" # Limpia la línea del spinner
        echo "$line"
      fi
    done &

  # Ejecutar el comando en segundo plano
  (
    "${cmd[@]}" >"$pipefile" 2>&1
  ) &
  local pid=$!

  local delay=0.1
  local spinstr='-\|/'

  tput civis
  local i=0
  while kill -0 "$pid" 2>/dev/null; do
    printf "\r%s  " "${spinstr:i++%${#spinstr}:1}"
    sleep "$delay"
  done

  wait "$pid"
  local exit_code=$?

  tput cnorm
  printf "\r\033[K" # Limpia la línea del spinner final

  rm -f "$tmpfile" "$pipefile"

  return $exit_code
}

# Instalar paquetes apt
install_apt_packages() {
  sudo apt-get update && sudo apt-get upgrade -y
  sudo apt-get install -y --fix-broken
  local packages=("$@")

  if ! command_exists apt; then
    log_error "APT is not available on this system."
  fi

  log_info "Updating APT package lists..."
  sudo apt update

  for pkg in "${packages[@]}"; do
    if dpkg -s "$pkg" &>/dev/null; then
      log_info "$pkg is already installed (APT)."
    else
      log_info "Installing $pkg via APT..."
      if ! sudo apt install -y "$pkg"; then
        log_warn "Failed to install $pkg via APT."
      fi
    fi
  done
}

# instalar paquetes snap
install_snap_packages() {
  local packages=("$@")

  check_snap

  for pkg in "${packages[@]}"; do
    if snap list "$pkg" &>/dev/null; then
      log_info "$pkg ya está instalado (Snap)."
    else
      log_info "Instalando $pkg con Snap..."
      if ! sudo snap install "$pkg"; then
        log_warn "No se pudo instalar $pkg con Snap."
      fi
    fi
  done
}

# Instalar herramientas Volta globales
install_volta_packages() {
  local packages=("$@")

  if ! command_exists volta; then
    log_warn "Volta no está instalado. Saltando instalación de herramientas Volta."
    return
  fi

  for tool in "${packages[@]}"; do
    if volta list | grep -q "^$tool"; then
      log_info "$tool ya está instalado con Volta."
    else
      log_info "Instalando $tool con Volta..."
      if ! volta install "$tool"; then
        log_warn "No se pudo instalar $tool con Volta."
      fi
    fi
  done
}

# Instalar paquetes npm globales (sin Volta)
install_npm_global_packages() {
  local packages=("$@")

  if command_exists volta; then
    log_warn "Volta está instalado, se recomienda usar install_volta_packages en lugar de npm globales."
    return
  fi

  if ! command_exists npm; then
    log_warn "npm no está instalado. No se pueden instalar paquetes npm globales."
    return
  fi

  for pkg in "${packages[@]}"; do
    if npm list -g --depth=0 | grep -q "$pkg"; then
      log_info "$pkg ya está instalado globalmente con npm."
    else
      log_info "Instalando $pkg con npm -g..."
      if ! npm install -g "$pkg"; then
        log_warn "No se pudo instalar $pkg con npm."
      fi
    fi
  done
}

# Instalar paquetes pip3
install_pip_packages() {
  local packages=("$@")

  if ! command_exists pip3; then
    log_warn "pip3 no está instalado. No se pueden instalar paquetes Python."
    return
  fi

  for pkg in "${packages[@]}"; do
    local pkg_name="${pkg%%==*}"
    if pip3 show "$pkg_name" &>/dev/null; then
      log_info "$pkg ya está instalado con pip3."
    else
      log_info "Instalando $pkg con pip3..."
      if ! pip3 install "$pkg"; then
        log_warn "No se pudo instalar $pkg con pip3."
      fi
    fi
  done
}

install_pipx_packages() {
  local packages=("$@")

  if ! command_exists pipx; then
    log_info "pipx no está instalado. Instalándolo..."

    if command_exists pip3; then
      pip3 install --user pipx || log_error "No se pudo instalar pipx"
      pipx ensurepath
      log_info "pipx instalado correctamente."
    else
      log_warn "pip3 no está disponible. No se puede instalar pipx."
      return
    fi
  fi

  for pkg in "${packages[@]}"; do
    if pipx list | grep -q "$pkg"; then
      log_info "$pkg ya está instalado con pipx."
    else
      log_info "Instalando $pkg con pipx..."
      if ! pipx install "$pkg"; then
        log_warn "No se pudo instalar $pkg con pipx."
      fi
    fi
  done
}

# Instalar paquetes desde un Brewfile
install_brewfile() {
  local brewfile_path="$1"

  check_brew

  if [[ ! -f "$brewfile_path" ]]; then
    log_error "No se encontró el Brewfile en: $brewfile_path"
    return 1
  fi

  log_info "Instalando paquetes desde Brewfile: $brewfile_path"

  # Redirigimos salida al log
  if brew bundle --file="$brewfile_path" >>"$LOG_FILE" 2>&1; then
    log_info "Todos los paquetes del Brewfile fueron instalados correctamente."
  else
    log_warn "Ocurrió un error al ejecutar 'brew bundle'. Revisa $LOG_FILE para más detalles."
  fi
}

# Verifica e instala stow si no está instalado
install_stow_if_needed() {
  if ! command_exists stow; then
    log_info "GNU Stow no está instalado. Instalando..."
    case "$OS" in
    "Linux")
      sudo apt install -y stow || log_error "No se pudo instalar stow"
      ;;
    "macOS")
      brew install stow || log_error "No se pudo instalar stow"
      ;;
    *)
      log_error "Sistema operativo no soportado para instalar stow"
      ;;
    esac
    log_info "GNU Stow instalado correctamente."
  fi
}

# Aplica stow solo en paquetes dentro de os/unix/packages
install_stow_packages() {
  local dotfiles_dir="${1:-$DEFAULT_DOTFILES_DIR}"

  check_brew
  install_stow_if_needed

  log_info "Instalando dotfiles desde: $dotfiles_dir"

  local stow_target="$dotfiles_dir/os/unix/packages"
  if [[ -d "$stow_target" ]]; then
    for dir in "$stow_target"/*/; do
      local package_name
      package_name="$(basename "$dir")"

      # Saltar 'vscode' si estamos en macOS
      if [[ "$OS" == "macOS" && "$package_name" == "vscode" ]]; then
        log_warn "Saltando paquete 'vscode' en macOS"
        continue
      fi

      log_info "Stowing $package_name..."
      if ! stow -d "$stow_target" -t "$HOME" "$package_name"; then
        log_warn "No se pudo stowear $package_name."
      else
        log_info "$package_name instalado correctamente."
      fi
    done
  else
    log_warn "Directorio de paquetes no encontrado: $stow_target"
  fi
}

# Hacer zsh el shell por defecto
make_zsh_default() {
  if command_exists zsh; then
    log_info "Zsh está instalado. Estableciendo como shell por defecto..."
    chsh -s "$(which zsh)" || log_warn "No se pudo cambiar el shell por defecto."

    log_info "Instalando Zimfw..."
    #curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh || log_warn "Error instalando zim"
    if command_exists zimfw; then
      zimfw install
    else
      log_warn "No se pudo encontrar zimfw"
    fi
  else
    log_error "Zsh no está instalado. No se puede establecer como shell por defecto."
  fi
}

# Instalar fuentes personalizadas
dotfiles_install_fonts() {
  log_info "Instalando fuentes personalizadas..."
  check_or_create_dir "$DEFAULT_FONTS_DIR"

  if command_exists gh; then
    gh auth login
    gh repo clone erickvasm/DankMono "$DEFAULT_FONTS_DIR" || log_warn "No se pudo clonar el repositorio de fuentes."
    echo "Clonando fuentes DankMono..."
  else
    log_warn "No se pudo encontrar gh"
  fi

  log_info "Descargando fuentes Hack..."
  curl -LJO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip
  unzip -o Hack.zip -d "$DEFAULT_FONTS_DIR/Hack"
  rm Hack.zip
}

# Print  logo
print_logo() {
  cat <<"EOF"
    ███████╗██████╗ ██╗ ██████╗██╗  ██╗██╗   ██╗ █████╗ ███████╗███╗   ███╗
    ██╔════╝██╔══██╗██║██╔════╝██║ ██╔╝██║   ██║██╔══██╗██╔════╝████╗ ████║
    █████╗  ██████╔╝██║██║     █████╔╝ ██║   ██║███████║███████╗██╔████╔██║
    ██╔══╝  ██╔══██╗██║██║     ██╔═██╗ ╚██╗ ██╔╝██╔══██║╚════██║██║╚██╔╝██║
    ███████╗██║  ██║██║╚██████╗██║  ██╗ ╚████╔╝ ██║  ██║███████║██║ ╚═╝ ██║
    ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝
EOF
}
