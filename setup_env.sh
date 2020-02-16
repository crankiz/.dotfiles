#!/bin/bash

ZSHRC="${HOME}/.zshrc"
ZSHPATH="${HOME}/.zsh"

# Install from pkg manager
echo -e "Install packages via package manager\n"
readarray -t pkg_list < <(curl -fsSL https://raw.githubusercontent.com/crankiz/.dotfiles/master/packages.txt)
pacman -S ${pkg_list[@]} 

# Git clone my dotfiles
echo -e "Git clone my dotfiles\n"
git clone https://github.com/crankiz/.dotfiles.git ${HOME}/.dotfiles || cd ${HOME}/.dotfiles && git pull && cd ${HOME}


# Create zsh folders
if [[ -d ${HOME}/.zsh/.zfunctions ]] || mkdir -p ${HOME}/.zsh/.zfunctions

# Function for install plugins
function gitclone(){
    git clone git://github.com/$1/$2.git ${ZSHPATH}/$2
}

# Install zsh plugins
gitclone "denysdovhan" "spaceship-prompt"
gitclone "zsh-users" "zsh-autosuggestions"
gitclone "zsh-users" "zsh-completions"
gitclone "zsh-users" "zsh-syntax-highlighting"

# 
rm -f ${HOME}/.zcompdump; compinit
ln -sf "${ZSHPATH}/spaceship-prompt/spaceship.zsh"  "${ZSHPATH}/.zfunctions/prompt_spaceship_setup"
