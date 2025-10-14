#!/bin/sh

# polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# captura de pantalla
flameshot &

# keyboard layout
setxkbmap -layout us -variant intl &

# docker
dockerd &

# Wayland config

# wallpaper swww
swww-daemon &
swww img ~/dotfiles/wallpapers/gruvbox/1-grubox.jpg &

# Xorg config

# wallpaper with feh
# ~/.fehbg &

# picom 
# picom &

# bar
# polybar &


