#!/usr/bin/env bash

# Read package list from git repo
readarray -t pkg_list < <(curl -fsSL https://raw.githubusercontent.com/crankiz/.dotfiles/master/packages.txt)

# Installing packages
echo -e "Installing ${pkg_list[@]}\n"
for pkg in ${pkg_list[@]}
do
    command -v $pkg &> /dev/null || sudo pacman --noconfirm -S $pkg || sudo apt install -y $pkg
done

# Git clone my dotfiles
echo -e "Git clone my dotfiles\n"
if git clone https://github.com/crankiz/.dotfiles.git ${HOME}/.dotfiles; then :
else
    cd ${HOME}/.dotfiles && git pull && cd ${HOME}
fi

# Create .zsh_plugins directory
if [ ! -d "${HOME}/.zsh_plugins" ]; then
  mkdir ${HOME}/.zsh_plugins
fi

# Install plugins and themes
echo -e "Git clone powerlevel10k\n"
if git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${HOME}/.zsh_plugins/powerlevel10k; then :
else
	cd ${HOME}/.zsh_plugins/powerlevel10k && git pull && cd ${HOME}
fi
echo -e "Git clone zsh-autosuggestions\n"
if git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ${HOME}/.zsh_plugins/zsh-autosuggestions; then :
else
	cd ${HOME}/.zsh_plugins/zsh-autosuggestions && git pull && cd ${HOME}
fi
echo -e "Git clone zsh-completions\n"
if git clone --depth=1 https://github.com/zsh-users/zsh-completions.git ${HOME}/.zsh_plugins/zsh-completions; then :
else
	cd ${HOME}/.zsh_plugins/zsh-completions && git pull && cd ${HOME}
fi
echo -e "Git clone zsh-syntax-highlighting\n"
if git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.zsh_plugins/zsh-syntax-highlighting; then :
else
	cd ${HOME}/.zsh_plugins/zsh-syntax-highlighting && git pull && cd ${HOME}
fi
echo -e "Git clone powerline_fonts\n"
if git clone --depth=1 https://github.com/powerline/fonts.git ${HOME}/.zsh_plugins/powerline_fonts; then :
else
	cd ${HOME}/.zsh_plugins/powerline_fonts && git pull && cd ${HOME}
fi

if ${HOME}/.zsh_plugins/powerline_fonts && rm -rf ${HOME}/.zsh_plugins/powerline_fonts; then
	echo -e "\npowerline_fonts Installed\n"
else
	echo -e "\npowerline_fonts Installation Failed\n"
fi

# curl -s https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf -o ${HOME}/.dotfiles/fonts
# curl -s https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf -o ${HOME}/.dotfiles/fonts
# curl -s https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf -o ${HOME}/.dotfiles/fonts
# curl -s https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf -o ${HOME}/.dotfiles/fonts


touch ${HOME}/.zshrc
echo -e "\nSudo access is needed to change default shell\n"
if chsh -s $(which zsh); then
    cd ${HOME}/.dotfiles
    stow --adopt bash
    stow --adopt vim
    stow --adopt zsh
    stow --adopt p10k
    cd ${HOME}
	echo -e "Installation Successful, exit terminal and enter a new session"
else
	echo -e "Something is wrong"
fi
exec $(which zsh) -i 
