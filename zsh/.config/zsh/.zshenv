unsetopt GLOBAL_RCS
export ZDOTDIR="$HOME/.config/zsh"

export EDITOR=nvim
export MOCWORD_DATA=$HOME/.local/share/mocword/mocword.sqlite

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

if [ -d /home/linuxbrew/.linuxbrew/bin ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  if command -v mise > /dev/null 2>&1; then
    eval "$(mise activate zsh)"
  elif command -v asdf > /dev/null 2>&1; then
    . $(brew --prefix asdf)/libexec/asdf.sh
  fi
else
  if command -v mise > /dev/null 2>&1; then
    eval "$(mise activate zsh)"
  elif test -f $HOME/.asdf/asdf.sh; then
    . $HOME/.asdf/asdf.sh
  fi
fi

# if test -f $HOME/.tok2/profile; then
#   source "$HOME/.tok2/profile"
# fi

if test -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi
if test -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi

if [ -e "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

if test -f $HOME/.config/zsh/.zshenv.local; then
  source "$HOME/.config/zsh/.zshenv.local"
fi
