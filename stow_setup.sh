#!/bin/bash
# Not finished

readarray -d '' array < <(find ~/.dotfiles -mindepth 1 -maxdepth 1 -type d -printf "%f\n")


for i in "${array[@]}"
do :
    if stow --no $i ; then
        echo "Create symlinks for $i"
    else
        echo "Conflict occurd for $i do you want to override"

    fi
done


