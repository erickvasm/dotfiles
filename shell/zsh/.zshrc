# -----------------
# Zsh configuration
# -----------------

## History
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=5000
HISTSIZE=5000
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
export HISTTIMEFORMAT="%F %T "

## Autocd
setopt +o nomatch
setopt CORRECT_ALL

## Word Characters
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Aliases
# -----------------

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
alias gd="git -c color.status=always status --short |
  fzf --height 100% --ansi \
  --preview '(git diff HEAD --color=always -- {-1} | sed 1,4d)' \
  --preview-window right:65% |
  cut -c4- |
  sed 's/.* -> //' |
  tr -d '\n' |
  pbcopy"

# -----------------
# Zim configuration
# -----------------
zstyle ':zim:zmodule' use 'degit'

# Async mode for autocompletion
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300

# ------------------
# Initialize modules
# ------------------
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

source ${ZIM_HOME}/init.zsh

# Starship
command -v starship > /dev/null && eval "$(starship init zsh)"

# PATH
export PATH="$HOME/.local/bin:/opt/nvim-linux64/bin:$PATH"

# Zsh terminfo
zmodload -F zsh/terminfo +p:terminfo
