# The following lines were added by compinstall
zstyle :compinstall filename '/home/thanasis/.zshrc'
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Set prompt
[[ -a ~/.zsh_prompt ]] && source ~/.zsh_prompt

# Aliases
alias ls='ls -hp --color=auto'
alias sl='ls'
alias ll='ls -l'
alias la='ll -lA'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ping='ping -c 3'
alias cower="cower --color='auto'"

setopt completealiases

# Exports
export EDITOR="/usr/bin/vim"

PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
if [ -d /home/`whoami`/dotfiles/util_scripts ]; then
    PATH="/home/`whoami`/dotfiles/util_scripts:$PATH"
fi

# history stuff
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

## fix zsh annoying history behavior
#h() { if [ -z "$*" ]; then history 1; else history 1 | egrep "$@"; fi; }

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# keybindings

bindkey -e

bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

bindkey '\e[1~' beginning-of-line
bindkey '\e[2~' overwrite-mode
bindkey '\e[3~' delete-char
bindkey '\e[4~' end-of-line
bindkey '\e[5~' up-line-or-history
bindkey '\e[6~' down-line-or-history
bindkey '^?' backward-delete-char
bindkey '\e[D' backward-char
bindkey '\e[C' forward-char

