#!/bin/bash

package_list="https://raw.githubusercontent.com/crankiz/.dotfiles/master/packages.csv"

### Help text

### error handling
error(){
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    printf "${RED}Error${NC}\t%s\n\n" "$1"
}

info(){
    GREEN='\033[0;32m'
    NC='\033[0m' # No Color
    printf "${GREEN}Done${NC}\t%s\n\n" "$1"
}

### Create home dir structure
tree=( ".config/zsh/plugins" ".local/bin" ".local/share" "script" "repos")
for dir in "${tree[@]}"; do
    [[ -d "${HOME}/${dir}" ]] && info "Directory ${HOME}/${dir} already exists" || (mkdir -p "${HOME}/${dir}" && info "Directory ${HOME}/${dir} created")
done

### Install package from distro reposotory
pkgmgr=$(command -v pacman apt dnf 2> /dev/null) # Full path to package manager
pkgmgr=${pkgmgr##*/} # Trunk path

case "${pkgmgr}" in
    pacman)
        install_pkg(){
            pacman -S --noconfirm "$1"
    };;
    apt)
        install_pkg(){
            apt install --yes "$1"
    };;
    dnf)
        install_pkg(){
            yum install --assumeyes "$1"
    };;
    *)
        error "No package manager found"
esac

readarray -d '' repo_pkg < <(awk -F "," '/^R/{print $2}' <<< "$(curl -fsSL ${package_list})")

install_repo_pkg(){
    for pkg in "${repo_pkg[@]}"; do
        install_pkg "${pkg}" && info "Package ${pkg} installed succesfully" || error "Couldn't install ${pkg}"
    done
}

[[ "$EUID" -eq 0 ]] && install_repo_pkg|| error "Installing package from ${pkgmgr} require root"

### Install from git repo
readarray -d '' git_pkg < <(awk -F "," '/^G/{print $2","$3}' <<< "$(curl -fsSL ${package_list})")

install_git(){
    IFS="," read -r git_url path <<< "$1"
    source=${source}
    repo_name=${git_url##*/}
    repo_name=${repo_name%%.git}
    git clone --depth=1 ${git_url} "${HOME}/${path}/${repo_name}" && info "Git repo ${repo_name} cloned successfully" || error "Git repo ${repo_name} couldn't be cloned"
}

# shellcheck disable=SC2068
for pkg in ${git_pkg[@]}
do
    install_git ${pkg}
done

### Install power fonts
${HOME}/.local/share/fonts/install.sh && info "Power fonts is installed" && rm -rf ${HOME}/.local/share/fonts/ && info "Power fonts is cleaned up" || error "Power fonst couldn't install"


### Install starship
readarray -d '' curl_pkg < <(awk -F "," '/^C/{print $2}' <<< "$(curl -fsSL ${package_list})")

install_curl(){
    curl -fsSL $1 | bash -s -- -b ${HOME}/.local/bin
}

for pkg in "${curl_pkg[@]}"; do
    install_curl ${pkg}
done



# TODO
# - [ ] Clone my own dotfiles
# - [ ] Create symlinks to dotfiles
# - [ ] Fix info and error functions, perhaps make on function?
# - [ ] Fix help text
# Need to be done