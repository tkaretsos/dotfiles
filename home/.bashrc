#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
alias liu_connect="ssh -Y thaka527@astmatix.ida.liu.se"
alias liu_mount="sshfs -o idmap=user thaka527@astmatix.ida.liu.se:/home/thaka527 \
                 /home/`whoami`/astmatix"
alias liu_unmount="fusermount -u /home/`whoami`/astmatix"

## NSC
alias triolith_connect="ssh -Y x_athka@triolith3.nsc.liu.se"
alias triolith_mount="sshfs x_athka@triolith.nsc.liu.se:/home/x_athka \
                      /home/`whoami`/triolith/"
alias triolith_unmount="fusermount -u /home/`whoami`/triolith/"

## GCC
alias gccaf="gcc -ansi -pedantic -Wall"
alias g++11="g++ -std=c++11 -pedantic -Wall -Wextra"
alias g++98="g++ -std=c++98 -pedantic -Wall -Wextra"

# exports
export EDITOR="/usr/bin/vim"
export PATH=$PATH:/usr/local/heroku/bin
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

