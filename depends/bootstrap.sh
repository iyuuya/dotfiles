#!/bin/sh

SCRIPT_DIR="$(cd $(dirname $0); pwd)"
cd $SCRIPT_DIR

brew bundle

if [ ! -d $HOME/.cargo ]; then
  echo "==> Install rust for build alacritty"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! command -V cargo > /dev/null 2>&1; then
  source "$HOME/.cargo/env"
fi

if [ ! -d /Applications/Alacritty.app ]; then
  git clone --depth 1 https://github.com/alacritty/alacritty ~/.local/src/github.com/alacritty/alacritty
  cd ~/.local/src/github.com/alacritty/alacritty \
    && make app \
    && cp -r target/release/osx/Alacritty.app /Applications
fi

sh $SCRIPT_DIR/asdf.sh
