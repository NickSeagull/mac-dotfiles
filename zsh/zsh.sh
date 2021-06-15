export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/.local/bin:$HOME/.bin:$HOME/.nimble/bin"
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
alias lverdaccio='verdaccio -c ~/.verdaccio.yaml'
alias lpm='npm --registry=http://localhost:4873'
alias brs='brew search'
# alias brbu='brew bundle install --cleanup --file ~/.dotfiles/brew/Brewfile'
alias brbu='brew bundle install --file ~/.dotfiles/brew/Brewfile'
alias rezsh='source ~/.zshrc && echo ".zshrc reloaded!"'


export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh
if [ -e /Users/nick/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/nick/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
