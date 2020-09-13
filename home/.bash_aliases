#
# ~/.bash_aliases
#
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto -hp --group-directories-first'
else
    alias ls='ls -hp --group-directories-first'
fi
alias sl='ls'
alias ll='ls -o'
alias la='ls -oA'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ping='ping -c 4'
alias pss='ps aux'

