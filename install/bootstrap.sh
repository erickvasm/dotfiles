#!/bin/bash
set -euo pipefail

# Cargar funciones y variables
source ./utils.sh
source "$DEFAULT_DOTFILES_DIR/os/unix/linux/packages.conf"

main() {
  print_logo
  identify_os

  check_or_create_dir "$DEFAULT_DOTFILES_DIR"

  for script in "$DEFAULT_DOTFILES_DIR"/install/*.sh; do
    ejecutable "$script"
  done

  with_spinner "Stow para la gestión de paquetes" install_stow_packages

  log_info "Instalando paquetes esenciales..."
  if [[ "$OS" == "Linux" ]]; then
    ejecutable "$DEFAULT_DOTFILES_DIR/os/unix/linux/linux.sh"
    with_spinner "Configurando entorno Linux" "$DEFAULT_DOTFILES_DIR/os/unix/linux/linux.sh"
    with_spinner "Instalando paquetes APT" install_apt_packages "${APT[@]}"
    with_spinner "Instalando paquetes Snap" install_snap_packages "${SNAP[@]}"
    [[ -f "$HOME/.Xmodmap" ]] && xmodmap "$HOME/.Xmodmap"
  elif [[ "$OS" == "macOS" ]]; then
    ejecutable "$DEFAULT_DOTFILES_DIR/os/unix/mac/macos.sh"
    with_spinner "Instalando paquetes Brewfile" install_brewfile "$DEFAULT_DOTFILES_DIR/os/unix/mac/Brewfile"
    log_info "Configurando macOS..."
    "$DEFAULT_DOTFILES_DIR/os/unix/mac/macos.sh"
  fi

  with_spinner "Instalando fuentes" dotfiles_install_fonts
  with_spinner "Estableciendo Zsh como shell predeterminado" make_zsh_default

  log_info "Bootstrap finalizado correctamente 🎉"
}

main "$@"
