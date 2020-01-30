#!/usr/bin/env bash

# Clone dotfiles repo
git clone https://github.com/crankiz/.dotfiles.git ${HOME}/.dotfiles

# Read applications from file 
readarray pkg_mgr < ${HOME}/.dotfiles/packages.txt 

# Install all applications from array
sudo pacman --noconfirm -S ${pkg_mgr[@]}

# Deploy all dotfiles
stow --adopt bash
stow --adopt vim
stow --adopt zsh

# Install zsh and plugins and theme
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Install pfetch
#curl -fsSL https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch --output /usr/local/bin/pfetch
#chmod +x /usr/local/bin/pfetch
