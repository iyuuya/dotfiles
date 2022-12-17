unsetopt GLOBAL_RCS
export ZDOTDIR="$HOME/.config/zsh"

export EDITOR=nvim

path=(
  $HOME/.local/bin(N-/)
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

if test -f $HOME/.cargo/env; then
  source "$HOME/.cargo/env"
fi
if test -f $HOME/.asdf/asdf.sh; then
 source $HOME/.asdf/asdf.sh
fi
if test -f $HOME/.tok2/profile; then
  source "$HOME/.tok2/profile"
fi
