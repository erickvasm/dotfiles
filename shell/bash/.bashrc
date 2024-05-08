# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# starship -> activar solo si se desea usar starship
# eval "$(starship init bash)"
# export STARSHIP_CONFIG=/Users/graifin/.config/starship.toml

# nvim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
