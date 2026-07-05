# -----------------
# Environment Variables
# -----------------
export BASH_SILENCE_DEPRECATION_WARNING=1

# PATH configuration
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$HOME/.volta/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# fzf (Fuzzy Finder)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
