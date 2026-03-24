# 1. Options & Environment
DISABLE_UNTRACKED_FILES_DIRTY="true"

setopt AUTO_CD HIST_IGNORE_DUPS SHARE_HISTORY EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST

export EDITOR='nvim'

HISTFILE="$HOME/.zsh_history"
HISTSIZE=9999
SAVEHIST=1000

# 2. PATH
typeset -U path
path=(
  /opt/nvim-linux-x86_64/bin
  /home/linuxbrew/.linuxbrew/bin
  $path
)

# 3. Plugin config (before loading)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#767676,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1

# 4. Plugin manager (lazy build)
if [[ ! -f ~/.zsh_plugins.sh || ~/.zsh_plugins.txt -nt ~/.zsh_plugins.sh ]]; then
  source ~/.antidote/antidote.zsh
  antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
fi

source ~/.zsh_plugins.sh

# 5. Completion system
fpath=(~/.zfunc $fpath)

autoload -Uz compinit
compinit -C -d ~/.zcompdump

# background compile
{
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} >/dev/null 2>&1 &!

zstyle ':completion:*' menu select

# 6. Lazy-loaded tools
export NVM_DIR="$HOME/.nvm"

_lazy_nvm_load() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

for cmd in nvm node npm npx; do
  eval "$cmd() { _lazy_nvm_load; $cmd \"\$@\" }"
done

# 7. External env
[ -f "$HOME/.brew_env" ] && source "$HOME/.brew_env"

# 8. Aliases
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias sys.update='sudo apt update && sudo apt upgrade -y'
alias sys.upgrade='sudo apt full-upgrade -y'
alias sys.clean='sudo apt autoremove && sudo apt clean && sudo apt autoclean'
alias ncd='cd ~/Projects/03_autoformfill && source .venv/bin/activate && streamlit run main.py'

alias zsh.update='source ~/.antidote/antidote.zsh && antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh && rm -f ~/.zcompdump* && exec zsh'

# logico dark theme - direct loading may break
# find it by find command
# find ~/. -type f -name "logico*.zsh-theme"
source ~/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-logico-SLASH-logico-zsh-theme/logico-dark.zsh-theme