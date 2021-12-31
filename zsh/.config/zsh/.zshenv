unsetopt GLOBAL_RCS
export ZDOTDIR="$HOME/.config/zsh"

path=(
  /usr/local/bin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
  /usr/local/sbin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
  $path
)

source "$HOME/.cargo/env"

export GPG_TTY=$(tty)
