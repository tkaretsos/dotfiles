#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
alias ls='ls -h --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias grep='grep --color=auto'
alias ..='cd ..'
alias cls='clear'
alias ping='ping -c 3'
alias apache='sudo /etc/rc.d/httpd'
alias mysqls='sudo /etc/rc.d/mysqld'

# exports
export EDITOR="/usr/bin/vim"
export GIT_PS1_SHOWDIRTYSTATE="auto"
export GIT_PS1_SHOWSTASHSTATE="auto"
export GIT_PS1_SHOWUNTRACKEDFILES="auto"

# set the prompt
if [ -f $HOME/.bash_prompt ]; then
    . $HOME/.bash_prompt
else
    PS1='[\u@\h:\w]\$ '
fi

# enable bash completition when preciding:
complete -cf sudo
complete -cf man

