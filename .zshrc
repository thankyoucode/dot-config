# oh-my-zsh

export ZSH="$HOME/.oh-my-zsh"

# Theme selection
# 1. logico (manualy installed) 2. robbyrussell
export ZSH_THEME="logico"

# Shell options early for better performance
setopt AUTO_CD HIST_IGNORE_DUPS SHARE_HISTORY EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST
# Environment Variables
export EDITOR='nvim'
export LANG=en_US.UTF-8

# History config
HISTFILE="$HOME/.zsh_history"
HISTSIZE=9999
SAVEHIST=1000

# Auto-suggestions config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#767676,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Load antidote plugin manager and plugins with lazy-loading enabled
source ~/.antidote/antidote.zsh 

# Lazy load antidote bundles to speed startup
antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
source ~/.zsh_plugins.sh

# Remove redundant compinit calls, let oh-my-zsh handle it
# speed up completion loading:
autoload -Uz compinit
compinit -C  # Optional: to handle manualy

# Custom completion caching (run in background to avoid delay)
{
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!


source $ZSH/oh-my-zsh.sh

# nvim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# brew (package manager)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

# Temporary directory for snap Firefox and webdriver intigration
export TMPDIR="$HOME/temp"
mkdir -p $TMPDIR

# Aliases
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias sys.update='sudo apt update && sudo apt upgrade -y'
alias sys.upgrade='sudo apt full-upgrade -y'
alias sys.clean='sudo apt autoremove && sudo apt clean && sudo apt autoclean'
alias ncd='cd ~/Projects/03_autoformfill && source .venv/bin/activate && streamlit run main.py'

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select
