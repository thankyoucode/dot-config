# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme selection
# 1. logico 2. robbyrussell
export ZSH_THEME="logico"

# Shell options early for better performance
setopt AUTO_CD HIST_IGNORE_DUPS SHARE_HISTORY EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST

# Environment Variables
export EDITOR='nvim'
export LANG=en_US.UTF-8
export ANDROID_HOME=/usr/lib/android-sdk

# Paths - Prepend important dirs for priority
export ANDROID_SDK_ROOT="/usr/lib/android-sdk"
export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
export PATH="$ANDROID_SDK_ROOT/build-tools/34.0.0:$PATH"
export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH"
export ANDROID_NDK_HOME="$ANDROID_SDK_ROOT/ndk/27.1.12297006"
export PATH="$ANDROID_NDK_HOME:$PATH"

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

# Lazy load antidote bundles to speed startup (assuming antidote supports lazy loading)
antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
source ~/.zsh_plugins.sh

# Remove redundant compinit calls, let oh-my-zsh handle it
# If you want to speed up completion loading:
autoload -Uz compinit
compinit -C  # Optional: only if you want to handle yourself

# Custom completion caching (run in background to avoid delay)
{
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# Temporary directory for snap Firefox and webdriver
export TMPDIR="$HOME/temp"
mkdir -p $TMPDIR

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias sys.update='sudo apt update && sudo apt upgrade -y'
alias sys.upgrade='sudo apt full-upgrade -y'
alias sys.clean='sudo apt autoremove && sudo apt clean && sudo apt autoclean'
alias pythonsolve='source /home/jatkishan/.local/share/virtualenvs/solveWithPython-4w7AOZSU/bin/activate'
alias djangovenv='source /home/jatkishan/Projects/02_grow-earth/.venv/bin/activate'
alias startncd='cd ~/Projects/03_autoformfill; source .venv/bin/activate; streamlit run streamlit.py'


source $ZSH/oh-my-zsh.sh
