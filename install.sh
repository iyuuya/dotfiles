#!/bin/zsh

SCRIPT_DIR="$(cd $(dirname $0); pwd)"

PATH=/opt/ $PATH

mkdir -p $HOME/.local
cd $SCRIPT_DIR && stow -t $HOME zsh nvim lvim tmux ranger wezterm local_bin
zsh $SCRIPT_DIR/depends/bootstrap.sh
