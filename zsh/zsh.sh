export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/.local/bin:${GOPATH}/bin:${GOROOT}/bin:$HOME/.emacs.d/bin:$HOME/.cabal/bin:$HOME/.bin:$HOME/.nimble/bin"
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
