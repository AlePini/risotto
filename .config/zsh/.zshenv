# Environmental variables are set here.

EDITOR=/usr/bin/nvim

# ==================
# Additions to $PATH
# ==================
PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
PATH="$PATH:$HOME/.ghcup/bin"

# ============
# ~/ Clean-up:
# ============
GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
HISTFILE="$ZDOTDIR/.zsh_history"
PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
