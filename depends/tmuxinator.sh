#!/bin/zsh

if [ -d $HOME/.asdf ]; then
  source "$HOME/.asdf/asdf.sh"

  gem install tmuxinator
fi
