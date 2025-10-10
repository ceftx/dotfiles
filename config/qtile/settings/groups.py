# Claudio Mora
# https://github.com/ceftx/dotfiles

from libqtile.config import Key, Group
from libqtile.lazy import lazy
from .keys import mod, keys

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

groups = [Group(i) for i in [
    "   ", " 󰒃  ", "   ", "   ", "  ", "  "
]]

for i,group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend(
        [
            # Switch to workspace N
            Key(
                [mod],actual_key,
                lazy.group[group.name].toscreen(),
            ),
            # Send window to workspace N
            Key(
                [mod, "shift"],
                actual_key,
                lazy.window.togroup(group.name, switch_group=True),
            ),
        ]
    )


