# Profile file. Runs on login. Environmental variables are set here.

# =====================
# FIXES FOR STUPID SHIT
# =====================

# Fixing Java apps
export _JAVA_AWT_WM_NONREPARENTING=1
 
# Uniform Look Qt and GTK with QGtkSyle Theme
export QT_QPA_PLATFORMTHEME=gtk2
 
# Gnome-Keyring Fix
/etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# Avoid X Cursor
xsetroot -cursor_name left_ptr

# ==================
# Additions to $PATH
# ==================
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH="$PATH:/opt/lamp"
export PATH="$PATH:/home/pini/nand2tetris/tools"

# ============
# ~/ Clean-up:
# ============
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export ZDOTDIR="$HOME/.config/zsh"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"

# Other program settings:
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
