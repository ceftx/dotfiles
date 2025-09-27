# Configuración básica de Fish
set -gx HOME /home/$USER
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share

# PATH configurations
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/bin $PATH

# Editor preferences
set -gx EDITOR nvim
set -gx VISUAL nvim

# Language settings (si es necesario)
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# Configuración de Android SDK
set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx PATH $ANDROID_HOME/cmdline-tools/latest/bin $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/platforms $PATH
set -gx PATH $ANDROID_HOME/emulator $PATH
set -gx PATH $ANDROID_HOME/tools $PATH
set -gx PATH $ANDROID_HOME/tools/bin $PATH

set -gx PATH "/home/ceftx/.config/herd-lite/bin" $PATH
set -gx PHP_INI_SCAN_DIR "/home/ceftx/.config/herd-lite/bin" $PHP_INI_SCAN_DIR

function use-java25
    set -gx PATH (string match -v "*jvm*" $PATH)
    set -gx JAVA_HOME /usr/lib/jvm/java-25-openjdk
    set -gx PATH $JAVA_HOME/bin $PATH
    echo "Java 25 activado (JAVA_HOME: $JAVA_HOME)"
end

function use-java21
    # Elimina otras versiones del PATH
    set -gx PATH (string match -v "*jvm*" $PATH)
    set -gx JAVA_HOME /usr/lib/jvm/java-21-openjdk
    set -gx PATH $JAVA_HOME/bin $PATH
    echo "Java 21 activado (JAVA_HOME: $JAVA_HOME)"
end

function use-java17
    # Elimina otras versiones del PATH
    set -gx PATH (string match -v "*jvm*" $PATH)
    set -gx JAVA_HOME /usr/lib/jvm/java-17-openjdk
    set -gx PATH $JAVA_HOME/bin $PATH
    echo "Java 17 activado (JAVA_HOME: $JAVA_HOME)"
end

alias ts="tmux"
alias ls="eza -h -l -a --icons"
alias pnpx="pnpm dlx"

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting

    # ~/.config/fish/config.fish
    starship init fish | source
    nvm use lts --silent
    source "$HOME/.cargo/env.fish" # For fish 
end

# pnpm

set -gx PNPM_HOME "/home/ceftx/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
