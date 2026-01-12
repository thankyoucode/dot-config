export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# dotnet dev env
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$DOTNET_ROOT

# node, nvm dev env
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export ZSH="$HOME/.oh-my-zsh"