#!/bin/bash

echo "Instalando dotfiles..."

# Crear directorio .config si no existe
mkdir -p ~/.config

# Enlizar configuración de .config
ln -sf ~/dotfiles/config/fish ~/.config/fish
ln -sf ~/dotfiles/config/alacritty ~/.config/alacritty
ln -sf ~/dotfiles/config/starship.toml ~/.config/starship.toml
ln -sf ~/dotfiles/config/nvim ~/.config/nvim
ln -sf ~/dotfiles/config/picom ~/.config/picom
ln -sf ~/dotfiles/config/qtile ~/.config/qtile
ln -sf ~/dotfiles/config/polybar ~/.config/polybar

echo "Dotfiles instalados correctamente"
