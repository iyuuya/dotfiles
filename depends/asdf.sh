#!/bin/zsh

SCRIPT_DIR="$(cd $(dirname $0); pwd)"
cd $SCRIPT_DIR

if [ ! -d $HOME/.asdf ]; then
  git clone https://github.com/asdf-vm/asdf ~/.local/src/github.com/asdf-vm/asdf
  ln -s $HOME/.local/src/github.com/asdf-vm/asdf $HOME/.asdf
fi
source $HOME/.asdf/asdf.sh

if ! asdf plugin list | grep nodejs > /dev/null 2>&1; then
  asdf plugin add nodejs
fi

if ! asdf plugin list | grep ruby > /dev/null 2>&1; then
  asdf plugin add ruby
fi

if ! asdf plugin list | grep python > /dev/null 2>&1; then
  asdf plugin add python
fi

ln -sf $SCRIPT_DIR/.tool-versions $HOME/.tool-versions
asdf install
