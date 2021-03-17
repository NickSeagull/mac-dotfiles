export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/.local/bin:${GOPATH}/bin:${GOROOT}/bin:$HOME/.emacs.d/bin:$HOME/.cabal/bin:$HOME/.bin:$HOME/.nimble/bin"
export PATH="/usr/local/Cellar/emacs-plus@28/28.0.50/bin/:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.scripts:$PATH"
export GOKU_EDN_CONFIG_FILE="$HOME/.dotfiles/karabiner/karabiner.edn"


# We use `pure` as the prompt, see bottom
ZSH_THEME=""
ZSH_DISABLE_COMPFIX="true"
HIST_STAMPS="dd/mm/yyyy"

plugins=(
  git
  common-aliases
  node
  npm
  sudo
  yarn
  z
  colored-man-pages
  cp
)

source $ZSH/oh-my-zsh.sh

# Enable pure prompt (clone from repo)
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# Aliases
alias brew-reload='(cd ~/.dotfiles/brew && brew bundle)'
alias lverdaccio='verdaccio -c ~/.verdaccio.yaml'

if [ -e /Users/nick/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/nick/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh

# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f "/Users/nick/.ghcup/env" ] && source "/Users/nick/.ghcup/env" # ghcup-env
