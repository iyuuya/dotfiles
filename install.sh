#!/bin/sh

SCRIPT_DIR="$(cd $(dirname $0); pwd)"

cd $SCRIPT_DIR && stow -t $HOME zsh nvim
cd $SCRIPT_DIR/depends && brew bundle
