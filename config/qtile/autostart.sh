#!/bin/sh

# polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# bar
polybar &

# captura de pantalla
flameshot &

# keyboard layout
setxkbmap -layout us -variant intl &

# wallpaper with feh
~/.fehbg &
