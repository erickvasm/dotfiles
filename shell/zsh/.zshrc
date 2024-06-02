# -----------------
# Zsh configuration
# -----------------

## History
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY
setopt HIST_FCNTL_LOCK
setopt HIST_NO_STORE


## Autocd
setopt +o nomatch


WORDCHARS=${WORDCHARS//[\/]}
ENABLE_CORRECTION="true"

alias vim='nvim'
alias c="clear"
alias ..='cd ..'
alias update='sudo apt update && sudo apt upgrade'
alias ls="exa --icons"
alias ll="exa -a --icons"
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

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"

export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$HOME/.local/bin/":$PATH


zmodload -F zsh/terminfo +p:terminfo



