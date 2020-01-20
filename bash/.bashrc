# ~/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source external configs
source $HOME/.export
source $HOME/.aliases
source $HOME/.functions

# check the window size after each command and, if necessary,
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
else
    PS1='┌[\u@\h][\w]\n└╼ \$ '
fi

# Set 'man' colors
if [ "$color_prompt" = yes ]; then
        man() {
        env \
        LESS_TERMCAP_mb=$'\e[01;31m' \
        LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;44;33m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        man "$@"
        }
fi

unset color_prompt force_color_prompt

# Check if TTY is a remote session
HOSTNAME="arch"
export -p HOSTNAME
if [ -n "$SSH_TTY" ]; then
  PHOST="$(echo $HOSTNAME|tr '[:lower:]' '[:upper:]')"
else
  PHOST="$HOSTNAME"
fi

# Check if root
if [ $(id -u) -eq 0 ]; then
  PUSER="$(echo $USER|tr '[:lower:]' '[:upper:]')"
  PSYMBOL="#"
else
  PUSER="$USER"
  PSYMBOL="\$"
fi

PS1="\[\e[33m\]$PUSER\[\e[m\]@\[\e[91m\]\[\e[35m\]$PHOST\[\e[36m\] \w \[\e[m\]$PSYMBOL "

pfetch
