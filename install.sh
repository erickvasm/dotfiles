#!/bin/bash
# Instalador remoto de dotfiles: instala git si hace falta, clona (o
# actualiza) el repositorio en el directorio correcto y ejecuta el bootstrap.
#
# Uso recomendado (preserva el terminal interactivo para contraseñas y
# confirmaciones, igual que hace el instalador oficial de Homebrew):
#
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/erickvasm/dotfiles/main/install.sh)"
#
# Evita usar "curl ... | bash": al conectar la entrada estándar al pipe de
# curl, cualquier prompt (sudo, confirmaciones) dentro del bootstrap no
# tendría una terminal real de la que leer y el script podría colgarse o
# fallar en silencio.

set -euo pipefail

REPO_URL="https://github.com/erickvasm/dotfiles.git"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

info() { printf '\033[0;32m[INFO]\033[0m %s\n' "$1"; }
warn() { printf '\033[0;35m[WARN]\033[0m %s\n' "$1"; }
error() {
  printf '\033[0;31m[ERROR]\033[0m %s\n' "$1"
  exit 1
}

install_git() {
  command -v git &>/dev/null && return

  info "git no está instalado. Instalando..."
  case "$OSTYPE" in
  darwin*)
    if ! command -v brew &>/dev/null; then
      info "Instalando Homebrew (requerido para instalar git en macOS)..."
      NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
      fi
    fi
    brew install git
    ;;
  linux*)
    sudo apt-get update && sudo apt-get install -y git
    ;;
  *)
    error "Sistema operativo no soportado para instalar git automáticamente: $OSTYPE"
    ;;
  esac

  command -v git &>/dev/null || error "No se pudo instalar git."
  info "git instalado correctamente."
}

clone_or_update_dotfiles() {
  if [[ -d "$DOTFILES_DIR/.git" ]]; then
    info "El repositorio ya existe en '$DOTFILES_DIR'. Actualizando..."
    git -C "$DOTFILES_DIR" pull --ff-only
  elif [[ -e "$DOTFILES_DIR" ]]; then
    error "'$DOTFILES_DIR' ya existe y no es un repositorio git. Muévelo o elimínalo y vuelve a intentarlo."
  else
    info "Clonando dotfiles en '$DOTFILES_DIR'..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
  fi
}

main() {
  install_git
  clone_or_update_dotfiles

  local bootstrap="$DOTFILES_DIR/install/bootstrap.sh"
  chmod +x "$bootstrap"

  info "Ejecutando el bootstrap de dotfiles..."
  exec "$bootstrap"
}

main "$@"
