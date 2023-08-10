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
znap source unixorn/fzf-zsh-plugin
znap source Aloxaf/fzf-tab

# ============
# Custom alias
# ============
alias cat="echo '!! USE bat'; bat"
alias exa="exa -g --icons --git"
alias exal="exa -l"
alias exall="exa -l -a"
alias exalt="exa -1 --icons --git-ignore"

# Enable Zoxide for ZSH
eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
