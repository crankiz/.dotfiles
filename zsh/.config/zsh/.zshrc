# CrankiZ config for the Zoomer Shell


# Include hidden files in autocomplete:
setopt globdots
_comp_options+=(globdots)
autoload -U colors && colors
zstyle ':completion:*' menu yes select
zstyle ':completion:*:options:*' list-colors '=(#b) #(--[a-z-]#)=34=36=33'
eval $(dircolors -b)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Load aliases
[ -f "${HOME}/.config/aliasrc" ] && source ${HOME}/.config/aliasrc
[ -f "${HOME}/.config/functionrc" ] && source ${HOME}/.config/functionrc

autoload -U compinit

# History settings
alias history="history -i"
HISTSIZE=10000                              # How many lines of history to keep in memory
HISTFILE=${HOME}/.cache/.zsh_history        # Where to save history to disk
SAVEHIST=10000                              # Number of history entries to save to disk
HISTDUP=erase                               # Erase duplicates in the history file
setopt    hist_ignore_all_dups              # Erase oldest dupliate
setopt    appendhistory                     # Append history to the history file (no overwriting)
setopt    sharehistory                      # Share history across terminals
setopt    incappendhistory                  # Immediately append to the history file, not just when a term is killed
unsetopt  EXTENDED_HISTORY

# Load plugins
source ${ZDOTDIR}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fpath=(${ZDOTDIR}/plugins/zsh-completions/src/ $fpath)
rm -f ~/.zcompdump; compinit

# Set prompt
eval "$(starship init zsh)"