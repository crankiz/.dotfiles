#!/usr/bin/env bash

# Read package list from git repo
readarray -t pkg_list < <(curl -fsSL https://raw.githubusercontent.com/crankiz/.dotfiles/master/packages.txt)

# Installing packages
echo -e "Installing ${pkg_list[@]}\n"
for pkg in ${pkg_list[@]}
do
    command -v $pkg &> /dev/null || sudo pacman --noconfirm -S $pkg || sudo apt install -y $pkg
done

# Install zgen
echo -e "Installing zgen\n"
if git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"; then
	echo -e "Installed zgen\n"
fi

# Git clone my dotfiles
echo -e "Git clone my dotfiles\n"
if git clone https://github.com/crankiz/.dotfiles.git ${HOME}/.dotfiles; then :
else
    cd ${HOME}/.dotfiles && git pull && cd ${HOME}
fi

# Install plugins and themes


# INSTALL FONTS
if git clone https://github.com/powerline/fonts.git ${HOME}/powerline_fonts; then :
else
	cd ${HOME}/powerline_fonts && git pull 
fi

if ${HOME}/powerline_fonts/install.sh && rm -rf ${HOME}/powerline_fonts; then
	echo -e "\npowerline_fonts Installed\n"
else
	echo -e "\npowerline_fonts Installation Failed\n"
fi

curl -s https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf -o ${HOME}/.dotfiles/fonts
curl -s https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf -o ${HOME}/.dotfiles/fonts
curl -s https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf -o ${HOME}/.dotfiles/fonts
curl -s https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf -o ${HOME}/.dotfiles/fonts


echo -e "\nSudo access is needed to change default shell\n"

if chsh -s $(which zsh) && /bin/zsh -i -c upgrade_oh_my_zsh; then
    cd ${HOME}/.dotfiles
    stow --adopt bash
    stow --adopt vim
    stow --adopt zsh
    stow --adopt p10k
    cd ${HOME}
    source ~/.zshrc
	echo -e "Installation Successful, exit terminal and enter a new session"
else
	echo -e "Something is wrong"
fi
exit
