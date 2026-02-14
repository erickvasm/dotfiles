#!/bin/bash
set -euo pipefail

# Cargar funciones y variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/utils.sh"
source "$DEFAULT_DOTFILES_DIR/os/unix/linux/packages.conf"
source "$DEFAULT_DOTFILES_DIR/os/unix/python_node.conf"

main() {
  print_logo
  identify_os

  check_or_create_dir "$DEFAULT_DOTFILES_DIR" >>"$LOG_FILE" 2>&1

  for script in "$DEFAULT_DOTFILES_DIR"/install/*.sh; do
    ejecutable "$script" >>"$LOG_FILE" 2>&1
  done

  with_spinner "Stow para la gestión de paquetes" install_stow_packages

  log_info "Instalando paquetes esenciales..."
  if [[ "$OS" == "Linux" ]]; then
    ejecutable "$DEFAULT_DOTFILES_DIR/os/unix/linux/linux.sh" >>"$LOG_FILE" 2>&1
    with_spinner "Configurando entorno Linux" "$DEFAULT_DOTFILES_DIR/os/unix/linux/linux.sh"
    with_spinner "Instalando paquetes APT" install_apt_packages "${APT[@]}"
    with_spinner "Instalando paquetes Snap" install_snap_packages "${SNAP[@]}"
    [[ -f "$HOME/.Xmodmap" ]] && xmodmap "$HOME/.Xmodmap"
  elif [[ "$OS" == "macOS" ]]; then
    ejecutable "$DEFAULT_DOTFILES_DIR/os/unix/mac/macos.sh" >>"$LOG_FILE" 2>&1
    log_info "Instalando paquetes Brewfile"
    install_brewfile "$DEFAULT_DOTFILES_DIR/os/unix/mac/Brewfile"
    log_info "Configurando macOS..."
    "$DEFAULT_DOTFILES_DIR/os/unix/mac/macos.sh"
  fi

  with_spinner "Instalando herramientas Volta" install_volta_packages "${VOLTA_PACKAGES[@]}"
  with_spinner "Instalando paquetes npm globales" install_npm_global_packages "${NPM_GLOBALS[@]}"
  with_spinner "Instalando paquetes pip3" install_pip_packages "${PYTHON_PACKAGES[@]}"
  with_spinner "Instalando paquetes pipx" install_pipx_packages "${PIPX_PACKAGES[@]}"
  with_spinner "Instalando fuentes" dotfiles_install_fonts
  log_info "Estableciendo Zsh como shell predeterminado"
  make_zsh_default

  log_info "Bootstrap finalizado correctamente 🎉"
}

main "$@"
