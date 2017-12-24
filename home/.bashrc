#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
alias ls='ls -hp --color=auto --group-directories-first'
alias sl='ls'
alias ll='ls -l'
alias la='ls -lA'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ping='ping -c 3'
#alias wifi-clear='sudo rm /var/lib/dhcpcd/*'
#alias cower="cower --target=/tmp/ --color='auto'"
#alias mysql_start="sudo systemctl start mysqld"
#alias mysql_stop="sudo systemctl stop mysqld"

# exports
export EDITOR="/usr/bin/vim"
#export PATH=$PATH:/home/`whoami`/Documents/util_scripts
#export PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin

# set the prompt
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
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
[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
complete -cf sudo
complete -cf man

colors() {
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} # white
            bgc=${bgc#40} # black

            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        echo; echo
    done
}


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [ -d $HOME/.rvm/bin ]; then
    export PATH="$PATH:$HOME/.rvm/bin"
fi
