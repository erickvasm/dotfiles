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
alias pr="gh pr create -a @me -r mangulof -f"
alias update='sudo apt update && sudo apt upgrade'
alias remove='sudo apt remove'
alias autoremove='sudo apt autoremove'
alias install='sudo apt install'
alias purge='sudo apt purge'
alias addrepo='sudo add-apt-repository'
alias removerepo='sudo add-apt-repository --remove'
alias delete='rm -rf'