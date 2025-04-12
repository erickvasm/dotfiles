# Detección de sistema operativo
if [[ "$(uname)" == "Darwin" ]]; then
  alias update="brew update && brew upgrade && brew cleanup"
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$(uname)" == "Linux" ]]; then
  alias update='sudo apt update && sudo apt upgrade'
fi

# Alias comunes (válidos para ambos sistemas operativos)
alias vim='nvim'
alias c="clear"
alias ...='cd ..'
alias ls="eza --icons"
alias ll="eza -a --icons"

# Cargar configuraciones personalizadas
[ -f $HOME/.bash_prompt ] && . $HOME/.bash_prompt
