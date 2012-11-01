#!/bin/bash

if [[ "$(whoami)" == "root" ]]; then
  homedir="/root"
else
  homedir="/home/$(whoami)"
fi

# dotfiles
for f in `ls -a home/ | egrep .[^.]`; do
  fn=$(basename $f)
  rm -r $homedir/$fn
  ln -s `pwd`/home/$f $homedir/$fn
done

# utility scripts
mkdir -p $homedir/Documents/util_scripts
for f in `ls util_scripts`; do
  fn=$(basename $f)
  rm -r $homedir/Documents/util_scripts/$fn
  ln -s `pwd`/util_scripts/$f $homedir/Documents/util_scripts/$fn
done

# xfce4 shortkeys
if [[ "$(whoami)" != "root" ]]; then
  f1="xfce4-keyboard-shortcuts.xml"
  path=$homedir/.config/xfce4/xfconf/xfce-perchannel-xml/
  rm $path$f1
  cp xfce/$f1 $path

  # terminator
  rm -r $homedir/.config/terminator
  ln -s `pwd`/terminator $homedir/.config/
fi
