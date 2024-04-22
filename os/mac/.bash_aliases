alias ..="cd .."
alias c="clear"
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
alias ll="exa -l -g -a --icons"
alias ls="exa -a --icons"
alias pr="gh pr create -a @me -r mangulof -f"

# only for macOS
eval "$(/opt/homebrew/bin/brew shellenv)"
