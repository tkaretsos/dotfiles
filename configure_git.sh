#!/bin/bash
#
# ~/dotfiles/configure_git.sh
#
# configure git color and aliases
#

command="git config --global "
config=("color.ui auto"
        "alias.co checkout"
        "alias.br branch"
        "alias.cv \"commit -v\""
        "alias.st status"
        "alias.ff diff"
        "alias.cav \"commit -a -v\""
        "alias.cam \"commit -a -m\""
       )

for i in "${config[@]}"; do
    eval $command "${i}"
done

unset command
unset config
