if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

if [ -e ~/.orbstack/shell/init.zsh ]; then
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi
