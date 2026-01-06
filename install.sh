#!/bin/zsh

SCRIPT_DIR="$(cd $(dirname $0); pwd)"

PATH=/opt/ $PATH

mkdir -p $HOME/.local/bin
cd $SCRIPT_DIR && stow -t $HOME zsh nvim tmux ranger wezterm mise local_bin
zsh $SCRIPT_DIR/depends/bootstrap.sh
