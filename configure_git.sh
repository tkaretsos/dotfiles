#!/bin/bash
#
# ~/dotfiles/configure_git.sh
#
# configure git color and aliases
#

# set color
git config --global color.ui auto

# set aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cv "commit -v"
git config --global alias.st status
git config --global alias.ff diff
git config --global alias.cav "commit -v -a"
git config --global alias.cam "commit -a -m"
