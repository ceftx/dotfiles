#!/bin/bash

USER_NAME=""
INSTALL_FOR_ROOT=false

# Procesar parámetros
while [[ $# -gt 0 ]]; do
  case $1 in
  --user)
    USER_NAME="$2"
    shift 2
    ;;
  --root)
    INSTALL_FOR_ROOT=true
    shift
    ;;
  *)
    echo "Parámetro desconocido: $1"
    exit 1
    ;;
  esac
done

echo "Instalando dotfiles..."

# Crear directorio .config si no existe
mkdir -p ~/.config

# Enlazar configuración con root (solo si es necesario)
if [ "$INSTALL_FOR_ROOT" = "true" ]; then
  echo "Configurando para root..., usuario: $USER_NAME"
  mkdir -p /root/.config
  ln -sf /home/$USER_NAME/dotfiles/config/fish /root/.config/fish
  ln -sf /home/$USER_NAME/dotfiles/config/nvim /root/.config/nvim
  ln -sf /home/$USER_NAME/dotfiles/config/tmux /root/.config/tmux
  if [ -d "/home/$USER_NAME/.cargo/" ]; then
    ln -sf /home/$USER_NAME/.cargo /root/.cargo
  else
    echo "La configuración de nvim necesita que descargues rust y que exista la carpeta ~/.cargo,"
    echo "solo es para evitar un error de consola."
  fi
fi

if [ -n "$USER_NAME" ] && [ "$INSTALL_FOR_ROOT" = "false" ]; then
  echo "Configurando para usuario: $USER_NAME"
  echo "Para configurar root, ejecuta: sudo $0 --user nombre_usuario --root"
  # Enlazar configuración de .config (usuario actual)
  ln -sf /home/$USER_NAME/dotfiles/config/fish ~/.config/fish
  ln -sf /home/$USER_NAME/dotfiles/config/alacritty ~/.config/alacritty
  ln -sf /home/$USER_NAME/dotfiles/config/starship.toml ~/.config/starship.toml
  ln -sf /home/$USER_NAME/dotfiles/config/nvim ~/.config/nvim
  ln -sf /home/$USER_NAME/dotfiles/config/ranger ~/.config/ranger
  ln -sf /home/$USER_NAME/dotfiles/config/waybar ~/.config/waybar
  ln -sf /home/$USER_NAME/dotfiles/config/hypr ~/.config/hypr
  ln -sf /home/$USER_NAME/dotfiles/config/tmux ~/.config/tmux
fi

echo "Dotfiles instalados correctamente"
