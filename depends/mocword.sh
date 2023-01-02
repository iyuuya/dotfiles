#!/bin/zsh

SCRIPT_DIR="$(cd $(dirname $0); pwd)"
cd $SCRIPT_DIR

if [ ! -f $HOME/.local/share/mocword/mocword.sqlite ]; then
  wget https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz
  gunzip mocword.sqlite.gz

  mkdir -p $HOME/.local/share/mocword
  mv mocword.sqlite ~/.local/share/mocword/
fi

if ! command -V mocword > /dev/null 2>&1; then
  if ! command -V cargo > /dev/null 2>&1; then
    source "$HOME/.cargo/env"
  fi

  cargo install mocword
fi
