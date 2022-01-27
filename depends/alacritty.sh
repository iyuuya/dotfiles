#!/bin/sh

if [[ $OSTYPE == "darwin"* ]]; then
  if [ ! -d /Applications/Alacritty.app ]; then
    if ! command -V cargo > /dev/null 2>&1; then
      source "$HOME/.cargo/env"
    fi

    git clone --depth 1 https://github.com/alacritty/alacritty ~/.local/src/github.com/alacritty/alacritty
    cd ~/.local/src/github.com/alacritty/alacritty \
      && make app \
      && cp -r target/release/osx/Alacritty.app /Applications
  fi
fi
