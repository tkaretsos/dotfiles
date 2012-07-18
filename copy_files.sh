#!/bin/bash

if [[ "$(whoami)" == "root" ]]; then
  homedir="/root"
else
  homedir="/home/$(whoami)"
fi

for f in `ls -a home/ | egrep .[^.]`; do
  fn=$(basename $f)
  rm -r $homedir/$fn
  ln -s `pwd`/home/$f $homedir/$fn
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
