# GTK/Wayland defaults for Chromebook Sway profile

export GTK_THEME=Adwaita:dark
export XCURSOR_THEME=Bibata-Modern-Classic
export XCURSOR_SIZE=20

# Prefer Wayland for GTK apps, but allow X11 fallback
export GDK_BACKEND=wayland,x11

# Prefer Wayland for Qt apps where applicable
export QT_QPA_PLATFORM='wayland;xcb'
export QT_STYLE_OVERRIDE=Adwaita-Dark

