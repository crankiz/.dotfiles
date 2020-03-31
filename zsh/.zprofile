# Add my own PATH
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/scripts"

# Default programs: 
which nvim &>/dev/null && EDITOR="nvim" || EDITOR="nim"
export EDITOR="$EDITOR"
export VISUAL="$EDITOR"
export CODEEDITOR="vscodium"
export BROWSER="firefox"
export COLORTERM="truecolor"
export PAGER="less"

# Clean-up
export LESSHISTFILE="-"
export WGETRC="$HOME/.config/wget/wgetrc"
export ZDOTDIR="$HOME/.config/zsh"