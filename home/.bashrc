#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux -2

# aliases
alias ls='ls -hp --color=auto'
alias sl='ls'
alias ll='ls -l'
alias la='ls -lA'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ping='ping -c 3'
alias wifi-clear='sudo rm /var/lib/dhcpcd/*'
alias cower="cower --target=/tmp/ --color='auto'"
alias mysql_start="sudo systemctl start mysqld"
alias mysql_stop="sudo systemctl stop mysqld"

## LiU related stuff
alias liu_mount="sshfs -o idmap=user liu:/home/thaka527 ~/astmatix"
alias liu_unmount="fusermount -u ~/astmatix"

#TDDC88
alias pumi_mount="sshfs pumi:/home/thaka527 ~/pumi"
alias pumi_unmount="fusermount -u ~/pumi"

# virtualenv wrapper
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

## GCC
alias gccaf="gcc -ansi -pedantic -Wall"
alias g++11="g++ -std=c++11 -pedantic -Wall -Wextra"
alias g++98="g++ -std=c++98 -pedantic -Wall -Wextra"

# tmux
alias tmux="tmux -2" #force tmux to use 256 colors

# exports
export EDITOR="/usr/bin/vim"
export PATH=$PATH:/home/`whoami`/Documents/util_scripts

# set the prompt
if [ -f $HOME/.git-prompt.sh ]; then
    source $HOME/.git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE="auto"
    export GIT_PS1_SHOWSTASHSTATE="auto"
    export GIT_PS1_SHOWUNTRACKEDFILES="auto"
    export GIT_PS1_SHOWUPSTREAM="auto"
fi

if [ -f $HOME/.bash_prompt ]; then
    . $HOME/.bash_prompt
else
    PS1='[\u@\h:\w]\$ '
fi

# enable bash completition when preciding:
complete -cf sudo
complete -cf man

