alias ..="cd .."
alias c="clear"
alias update="brew update && brew upgrade && brew cleanup"
alias vim="nvim"
alias ll="exa -l -g -a --icons"
alias ls="exa -a --icons"
alias pr="gh pr create -a @me -r mangulof -f"

# only for macOS
eval "$(/opt/homebrew/bin/brew shellenv)"
