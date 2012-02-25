#!/bin/bash
#
# ~/dotfiles/configure_git.sh
#
# configure git color and aliases
#

cmd="git config --global"
configs=("color.ui auto"
         "alias.co checkout"
         "alias.br branch"
         "alias.cv \"commit --verbose\""
         "alias.st status"
         "alias.ff \"diff --ignore-all-space\""
         "alias.cav \"commit --all --verbose\""
         "alias.cam \"commit --all -m\""
        )

eval $cmd "--remove-section color"
eval $cmd "--remove-section alias"

for i in "${configs[@]}"; do
    eval $cmd "${i}"
done

unset cmd
unset configs
