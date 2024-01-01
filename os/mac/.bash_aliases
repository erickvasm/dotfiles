alias ..="cd .."
alias j17="export JAVA_HOME=$(/usr/libexec/java_home -v 17); java -version"
alias c="clear"
alias h="history"
alias update="brew update && brew upgrade && brew cleanup"
alias vim="nvim"
alias gac='function __gap() { git add -A && git commit -m "$1"; }; __gac'
alias gacp='function __gacp() { git add -A && git commit -m "$(printf "[Incidencia: RD-$1]\n\n$2")" && git push origin "$3"; }; __gacp'
alias gp='function __gp() { git add -A && git commit -m "$1" && git push origin "$2"; }; __gp'
alias ll="exa -l -g -a --icons"
alias ls="exa -a --icons"
alias cat="bat"
alias idea="~/Applications/IntelliJ\ IDEA\ Community\ Edition.app/Contents/MacOS/./idea &>/dev/null &"
alias pr="gh pr create -a @me -r mangulof -f"

# only for macOS
eval "$(/opt/homebrew/bin/brew shellenv)"