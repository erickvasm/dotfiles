alias ..="cd .."
alias c="clear"
alias h="history"
alias update="brew update && brew upgrade && brew cleanup"
alias vim="nvim"
alias gd="git -c color.status=always status --short |
  fzf --height 100% --ansi \
    --preview '(git diff HEAD --color=always -- {-1} | sed 1,4d)' \
    --preview-window right:65% |
  cut -c4- |
  sed 's/.* -> //' |
  tr -d '\n' |
  pbcopy"
alias gac='function __gap() { git add -A && git commit -m "$1"; }; __gac'
alias gacp='function __gacp() { git add -A && git commit -m "$(printf "[Incidencia: RD-$1]\n\n$2")" && git push origin "$3"; }; __gacp'
alias gp='function __gp() { git add -A && git commit -m "$1" && git push origin "$2"; }; __gp'
alias ll="exa -l -g -a --icons"
alias ls="exa -a --icons"
alias cat="bat"
alias pr="gh pr create -a @me -r mangulof -f"

# only for macOS
eval "$(/opt/homebrew/bin/brew shellenv)"
