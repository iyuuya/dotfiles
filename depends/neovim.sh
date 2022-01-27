#!/bin/sh

if [ -d $HOME/.asdf ]; then
  source "$HOME/.asdf/asdf.sh"
  
  gem install neovim
  npm i -g neovim
  pip install pynvim
fi
