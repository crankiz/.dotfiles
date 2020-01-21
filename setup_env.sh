#!/bin/bash

# package list
pkg_mgr=(
  vim
  curl
  git
  exa
  highlight
  windows95
)

pkg_git=(
  pfetch
  whaaaha
)

pkg_pip=(
  powerline-shell
  derp
)

pkg_mgr_ok=()
pkg_mgr_nok=()
pkg_git_ok=()
pkg_git_nok=()
pkg_pip_ok=()
pkg_pip_nok=()

# Default repo
for i in "${pkg_mgr[@]}"
do
  which $i &> /dev/null && pkg_mgr_ok+=($i) || pkg_mgr_nok+=($i)
done

# Python package
for i in "${pkg_pip[@]}"
do
  which $i &> /dev/null && pkg_pip_ok+=($i) || pkg_pip_nok+=($i)
done

# Github
for i in "${pkg_git[@]}"
do
  which $i &> /dev/null && pkg_git_ok+=($i) || pkg_git_nok+=($i)
done

echo -e "Default repository"
printf "✔ - %s\n" ${pkg_mgr_ok[@]}
printf "✖ - %s\n" ${pkg_mgr_nok[@]}
echo -e "\nGithub"
printf "✔ - %s\n" ${pkg_git_ok[@]}
printf "✖ - %s\n" ${pkg_git_nok[@]}
echo -e "\nPython"
printf "✔ - %s\n" ${pkg_pip_ok[@]}
printf "✖ - %s\n" ${pkg_pip_nok[@]}



check_os(){
  OS=$(( lsb_release -is || sed -n 's/^ID=\([0-9a-zA-Z]*$\)/\1/p' /etc/*release) 2>/dev/null |tr '[:upper:]' '[:lower:]')
  
  if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
  fi

  if [ $OS = "arch" ]; then
    pacman -S ${pkg_mgr_nok[@]}
  elif [ $OS = "ubuntu" ]; then
    apt install ${pkg_mgr_nok[@]}
  else
    echo "Could not install because the distribution is unknown"
    exit 1
  fi
}


while true; do
    read -p "Do you wish to install missing packages?" yn
    case $yn in
        [Yy]* ) check_os; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done