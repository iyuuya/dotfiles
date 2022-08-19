#!/bin/zsh

if [ ! -d $HOME/.cargo ]; then
  echo "==> Install rustup"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
