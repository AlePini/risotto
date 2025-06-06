# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Download Znap, if it's not there yet.
[[ -r $ZDOTDIR/plugins/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $ZDOTDIR/plugins/znap
source $ZDOTDIR/plugins/znap/znap.zsh

# =============
# Powerlevel10k
# =============
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon user host dir)
POWERLEVEL9K_MODE="nerdfont-complete"
znap prompt romkatv/powerlevel10k

# ===============
# OhMyZSH Imports
# ===============
znap source ohmyzsh/ohmyzsh lib/completion
znap source ohmyzsh/ohmyzsh lib/git
znap source ohmyzsh/ohmyzsh lib/history
znap source ohmyzsh/ohmyzsh lib/key-bindings
znap source ohmyzsh/ohmyzsh plugins/git
znap source ohmyzsh/ohmyzsh plugins/sudo

# ===================
# Syntax Highlighting
# ===================
znap source zdharma-continuum/fast-syntax-highlighting

# ================
# Autocompletition
# ================
znap source zsh-users/zsh-autosuggestions
znap source sunlei/zsh-ssh
# znap source unixorn/fzf-zsh-plugin
znap source Aloxaf/fzf-tab

# ============
# Custom alias
# ============
alias cat="bat"
alias eza="eza -g --icons --git"
alias ezal="eza -l"
alias ezall="eza -l -a"
alias ezalt="eza -1 --icons --git-ignore"
alias k="kubectl"

# My fedora install has zola installed with flatpak, but on termux is installed from main repos.
# So, when zola is not found in $PATH, try to alias with flatpak
if ! type "zola" &> /dev/null; then
  alias zola="flatpak run org.getzola.zola"
fi

# Enable Zoxide for ZSH
eval "$(zoxide init zsh)"

# Enable Zola completion for ZSH
if type "zola" &> /dev/null; then
  eval "$(zola completion zsh)"
fi

# Config FZF key-bindings and fuzzy completion
# source <(fzf --zsh)
source /usr/share/fzf/shell/key-bindings.zsh
if type "flux" &> /dev/null; then
  source <(flux completion zsh)
fi

# Don't ask why. But fzf doesn't like env being applied in .zshenv
export FZF_DEFAULT_OPTS="--height 75% --layout reverse --border --preview 'test -d {} && eza -g --icons --git -l -a -T -L 3 --color always {}/ || bat --theme='Dracula' --style=numbers,changes,grid --pager never  --color=always {} 2>/dev/null'"
export FZF_DEFAULT_COMMAND="fd -u"

# Copied from tmux-yank plugin
if type "clip.exe" &> /dev/null; then # WSL clipboard command
  export FZF_CLIP_CMD="clip.exe"
elif type "wl-copy" &> /dev/null; then # wl-clipboard: Wayland clipboard utilities
  export FZF_CLIP_CMD="wl-copy"
fi
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | $FZF_CLIP_CMD)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
  --preview-window=hidden"

# https://github.com/microsoft/WSL/issues/11261#issuecomment-2334775209
# Under WSL, we KINDA have Wayland, but not really, and that blows up Neovim. Ungh. :)
# Add an alias so if we actually WANT the pseudo wayland, we can haz.
if [[ $(uname -r | grep "microsoft") ]] then
        unset WAYLAND_DISPLAY
        alias wway='export WAYLAND_DISPLAY=wayland-0'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
