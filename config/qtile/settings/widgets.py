from libqtile import widget

# Paleta de colores moderna y coherente
colors = {
    'dark': '#1e1e2e',      # Fondo oscuro principal
    'light': '#cdd6f4',     # Texto claro
    'text': '#cdd6f4',      # Texto principal
    'focus': '#89b4fa',     # Azul suave para enfoque
    'active': '#a6e3a1',    # Verde para activo
    'inactive': '#6c7086',  # Gris para inactivo
    'urgent': '#f38ba8',    # Rojo suave para urgente
    'grey': '#45475a',      # Gris medio
    'color1': '#f38ba8',    # Rosa/Rojo - Clock
    'color2': '#fab387',    # Naranja - Layout
    'color3': '#a6e3a1',    # Verde - Network
    'color4': '#89dceb',    # Cyan - Updates
    'bg_alt': '#313244',    # Fondo alternativo
}

def base(fg='text', bg='dark'): 
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }

def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)

def icon(fg='light', bg='dark', fontsize=16, text="?"):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=0
    )

def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg),
        text="", # Icon: nf-oct-triangle_left
        fontsize=37,
        padding=-2
    )

def workspaces(): 
    return [
        separator(),
        widget.GroupBox(
            **base(fg='light'),
            font='Mononoki Nerd Font',
            fontsize=19,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(fg='focus'), fontsize=14, padding=5),
        separator(),
    ]

primary_widgets = [
    *workspaces(),
    
    separator(),
    
    # Updates section

    icon(bg="dark", fg="color4", fontsize=36, text=''),
    powerline('color4', 'dark'),
    icon(bg="color4", fg="dark", text=' '), # Icon: nf-fa-download
    widget.CheckUpdates(
        background=colors['color4'],
        foreground=colors['dark'],
        colour_have_updates=colors['dark'],
        colour_no_updates=colors['dark'],
        no_update_string='0',
        display_format='{updates}',
        update_interval=1800,
        custom_command='checkupdates',
    ),
    
    # Network section
    icon(bg="color4", fg="color3", fontsize=36, text=''),
    powerline('color3', 'color4'),
    icon(bg="color3", fg="dark", text=' '),  # Icon: nf-fa-feed
    widget.Net(**base(fg='dark', bg='color3'), interface='wlan0', format='{down} ↓↑ {up}'),
    
    # Layout section
    icon(bg="color3", fg="color2", fontsize=36, text=''),
    powerline('color2', 'color3'),
    widget.CurrentLayout(**base(fg='dark', bg='color2'), padding=5),
    
    # Clock section
    icon(bg="color2", fg="color1", fontsize=36, text=''),
    powerline('color1', 'color2'),
    icon(bg="color1", fg="dark", fontsize=17, text=' '), # Icon: nf-mdi-calendar_clock
    widget.Clock(**base(fg='dark', bg='color1'), format='%d/%m/%Y - %H:%M '),
    
    # Systray
    icon(bg="color1", fg="dark", fontsize=36, text=''),
    powerline('dark', 'color1'),
    widget.Systray(background=colors['dark'], padding=5),
]

secondary_widgets = [
    *workspaces(),
    
    separator(),
    
    # Layout section
    powerline('color2', 'dark'),
    widget.CurrentLayout(**base(fg='dark', bg='color2'), padding=5),
    
    # Clock section
    powerline('color1', 'color2'),
    icon(bg="color1", fg="dark", fontsize=17, text=' '),
    widget.Clock(**base(fg='dark', bg='color1'), format='%d/%m/%Y - %H:%M '),
    
    powerline('color1', 'color1'),
]

widget_defaults = {
    'font': 'Mononoki Nerd Font Bold',
    'fontsize': 14,
    'padding': 1,
}

extension_defaults = widget_defaults.copy()
