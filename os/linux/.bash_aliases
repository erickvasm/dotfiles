alias ..="cd .."
alias j17="export JAVA_HOME=$(/usr/libexec/java_home -v 17); java -version"
alias c="clear"
alias vim="nvim"
alias gacp='function __gacp() { git add -A && git commit -m "$(printf "[Incidencia: RD-$1]\n\n$2")" && git push origin "$3"; }; __gacp'
alias ll="exa -l -g -a --icons"
alias ls="exa -a --icons"
alias pr="gh pr create -a @me -r mangulof -f"
alias update='sudo apt update && sudo apt upgrade'
alias remove='sudo apt remove'
alias autoremove='sudo apt autoremove'
alias install='sudo apt install'
alias purge='sudo apt purge'
alias addrepo='sudo add-apt-repository'
alias removerepo='sudo add-apt-repository --remove'