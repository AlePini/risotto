# Profile file. Runs on login. Environmental variables are set here.

export EDITOR=/usr/bin/nvim

# =====================
# FIXES FOR STUPID SHIT
# =====================

# Fixing Java apps
export _JAVA_AWT_WM_NONREPARENTING=1
 
# Uniform Look Qt and GTK with QGtkSyle Theme
export QT_QPA_PLATFORMTHEME=gtk2
 
# ==================
# Additions to $PATH
# ==================
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH="$PATH:/opt/lampp"
export PATH="$PATH:$HOME/.ghcup/bin"

# ============
# ~/ Clean-up:
# ============
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$ZDOTDIR/.zsh_history"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"

# ============
# Keyring Fix
# ============
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# test for an existing bus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
  # if not found, launch a new one
  eval `dbus-launch --sh-syntax --exit-with-session`
  echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi
