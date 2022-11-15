unsetopt GLOBAL_RCS
export ZDOTDIR="$HOME/.config/zsh"

export EDITOR=nvim

path=(
  $HOME/go/bin(N-/)
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/local/bin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
  /usr/local/sbin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
  $path
)

source "$HOME/.cargo/env"
source $HOME/.asdf/asdf.sh
