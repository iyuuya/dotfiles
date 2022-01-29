#!/bin/sh

SCRIPT_DIR="$(cd $(dirname $0); pwd)"
cd $SCRIPT_DIR

if [[ $OSTYPE == "darwin"* ]]; then
  brew bundle
fi

sh $SCRIPT_DIR/rust.sh
sh $SCRIPT_DIR/alacritty.sh
sh $SCRIPT_DIR/asdf.sh
sh $SCRIPT_DIR/neovim.sh
sh $SCRIPT_DIR/tmuxinator.sh
