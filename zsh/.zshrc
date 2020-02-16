ZSHPATH="${HOME}/.zsh"

# Spaceship prompt
autoload -U promptinit; promptinit
prompt spaceship

# Source plugins
source ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Adding path for zsh functions
fpath=( "${ZSHPATH}/.zfunctions" "${ZSHPATH}/zsh-completions/src" $fpath )
autoload -U compinit
compinit
# Tab menu 
zstyle ':completion:*' menu select


# History settings
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY


# My prompt config
SPACESHIP_BATTERY_SHOW=always
SPACESHIP_TERRAFORM_SHOW=false
SPACESHIP_RUST_SHOW=false
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_HG_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_XCODE_SHOW=false
SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_HASKELL_SHOW=false
SPACESHIP_CONDA_SHOW=false
SPACESHIP_SWIFT_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_JULIA_SHOW=false
SPACESHIP_PYENV_SHOW=false
SPACESHIP_DOTNET_SHOW=false



