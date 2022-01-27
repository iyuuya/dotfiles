#!/bin/sh

SCRIPT_DIR="$(cd $(dirname $0); pwd)"

cd $SCRIPT_DIR && stow -t $HOME zsh nvim tmux alacritty ranger
sh $SCRIPT_DIR/depends/bootstrap.sh
