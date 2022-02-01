#!/bin/sh

if [ -d $HOME/.asdf ]; then
  source "$HOME/.asdf/asdf.sh"
  
  gem install neovim
  npm i -g neovim typescript-language-server
  pip install --upgrade pip
  pip install pynvim ranger-fm cmake-language-server
  asdf reshim python
fi
