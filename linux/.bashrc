. $HOME/.bash_prompt
export PATH="$HOME/.local/bin/":$PATH

alias ..="cd .."
alias c="clear"
alias h="history"
alias update="sudo apt-get update && sudo apt-get upgrade && sudo apte autoremove"
alias vim="lvim"
alias ga="git add ."
alias gs="git status"
alias gd="git diff"
alias gb="git branch"
alias gc="git commit"
alias gac="git add . && git commit"
alias ll="exa -l -g -a --icons"
alias ls="exa -a --icons"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
