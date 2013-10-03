#!/bin/sh

vga=$(xrandr | grep "VGA" | cut -d' ' -f1)
conn=$(xrandr | grep "VGA" | cut -d' ' -f2)

if [ $conn == "connected" ]; then
  xrandr --output $vga --mode 1920x1080 --primary --output LVDS1 --mode 1366x768 --left-of $vga
  xrandr --output $vga --mode 1920x1080 --primary
else
  xrandr --output LVDS1 --mode 1366x768 --primary
fi

