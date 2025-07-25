# ---- PATH setup ----
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:/opt/homebrew/bin:$PATH"

# ---- Aliases ----
alias python=python3
alias pip=pip3
alias vim=nvim

# ---- vi-style editing ----
# set -o vi

# ---- Oh My Zsh ----
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Minimal, custom prompt used

# ---- VCS info for custom prompt ----
autoload -Uz vcs_info

zstyle ':vcs_info:git*' formats " %F{blue}%b%f %m%u%c %a "
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' %F{green}✚%f'
zstyle ':vcs_info:*' unstagedstr ' %F{red}●%f'

precmd() {
  vcs_info
  print -P "%F{cyan}%n@%m%f:%F{yellow}%~%f ${vcs_info_msg_0_}"
}

PROMPT='%B%(!.#.$)%b '

# ---- Plugins ----
plugins=(
    git
    zsh-vi-mode
    zsh-autosuggestions
    fast-syntax-highlighting
    # zsh-autocomplete
)

# Load Oh My Zsh and its plugins
source $ZSH/oh-my-zsh.sh

# ---- fzf setup ----
# Use static files from Homebrew (instead of fzf --zsh)
# [ -f "$(brew --prefix)/opt/fzf/shell/completion.zsh" ] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
# [ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ] && source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
alias ls="eza"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
