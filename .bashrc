# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


source ~/.dotfiles/.aliases
source ~/.dotfiles/.functions
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:~/Scripts

# Check if TTY is a remote session
if [ -n "$SSH_TTY" ]; then
  PHOST="ARCH"
else
  PHOST="arch"
fi

# Check if root
if [ $(id -u) -eq 0 ]; then
  PUSER="echo $($USER|tr '[:lower:]' '[:upper:]')"
else 
  PUSER="$USER"
fi

PS1="\[\e[33m\]\u\[\e[m\]@\[\e[91m\]\[\e[35m\]$PHOST\[\e[36m\] \w \[\e[m\]\$ "

alias config='/usr/bin/git --git-dir=/home/crankiz/.cfg/ --work-tree=/home/crankiz'
alias config='/usr/bin/git --git-dir=/home/crankiz/.cfg/ --work-tree=/home/crankiz'
