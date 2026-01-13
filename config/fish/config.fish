# Temporaly
# fix crash open tauri app 
set -gx WEBKIT_DISABLE_DMABUF_RENDERER 1

# Qt compatibility
set -gx QT_QPA_PLATFORM wayland

# Configuración básica de Fish - ADAPTATIVA
if test (id -u) -eq 0
    # Si somos root
    set -gx HOME /root
    set -gx USER root
else
    # Si somos usuario normal
    set -gx HOME /home/$USER
    set -gx USER $USER
end

# Configuración básica de Fish
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

set -gx ANDROID_SKD_ROOT $HOME/Android/Sdk
export ANDROID_SDK_ROOT="~/Android/Sdk"

set -gx PATH $ANDROID_HOME/cmdline-tools/latest/bin $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/platforms $PATH
set -gx PATH $ANDROID_HOME/emulator $PATH
set -gx PATH $ANDROID_HOME/tools $PATH
set -gx PATH $ANDROID_HOME/tools/bin $PATH

set -gx PATH "/home/ceftx/.config/herd-lite/bin" $PATH
set -gx PHP_INI_SCAN_DIR "/home/ceftx/.config/herd-lite/bin" $PHP_INI_SCAN_DIR

set -gx CHROME_EXECUTABLE /usr/bin/google-chrome-stable $CHROME_EXECUTABLE
function use-java17
    set -l silent false

    # Verificar modo silencioso
    if contains -- --silent $argv
        set silent true
    end
    if contains -- -s $argv
        set silent true
    end

    # Elimina otras versiones del PATH
    set -gx PATH (string match -v "*jvm*" $PATH)
    set -gx JAVA_HOME /usr/lib/jvm/java-17-openjdk
    set -gx PATH $JAVA_HOME/bin $PATH

    if not $silent
        echo "Java 17 activado (JAVA_HOME: $JAVA_HOME)"
    end
end

function use-java21
    set -l silent false

    # Verificar modo silencioso
    if contains -- --silent $argv
        set silent true
    end
    if contains -- -s $argv
        set silent true
    end

    set -gx PATH (string match -v "*jvm*" $PATH)
    set -gx JAVA_HOME /usr/lib/jvm/java-21-openjdk
    set -gx PATH $JAVA_HOME/bin $PATH

    if not $silent
        echo "Java 21 activado (JAVA_HOME: $JAVA_HOME)"
    end
end

function use-java25
    set -l silent false

    # Verificar modo silencioso
    if contains -- --silent $argv
        set silent true
    end
    if contains -- -s $argv
        set silent true
    end
    set -gx PATH (string match -v "*jvm*" $PATH)
    set -gx JAVA_HOME /usr/lib/jvm/java-25-openjdk
    set -gx PATH $JAVA_HOME/bin $PATH

    if not $silent
        echo "Java 25 activado (JAVA_HOME: $JAVA_HOME)"
    end
end

alias ts="tmux"
alias nv="nvim"
alias ls="eza -h -l -a --icons"
alias pnpx="pnpm dlx"

alias anti="~/Downloads/Antigravity/antigravity &"

function load_cargo_if_available
    if test (id -u) -ne 0; and test -f "$HOME/.cargo/env.fish"
        source "$HOME/.cargo/env.fish"
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting

    # ~/.config/fish/config.fish
    starship init fish | source

    if test (id -u) -ne 0
        # nvm solo si está instalado

        use-java21 --silent

        load_cargo_if_available
    end

end

set -g fish_user_paths /home/ceft/Work/sdks/flutter/bin
# pnpm

set -gx PNPM_HOME "/home/ceftx/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# opencode
fish_add_path /home/ceftx/.opencode/bin
