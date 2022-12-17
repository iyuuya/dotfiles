#!/bin/zsh

SCRIPT_DIR="$(cd $(dirname $0); pwd)"

mkdir -p $HOME/.local
cd $SCRIPT_DIR && stow -t $HOME zsh nvim tmux alacritty ranger wezterm local_bin
zsh $SCRIPT_DIR/depends/bootstrap.sh
