#!/bin/zsh

if [[ $OSTYPE == "darwin"* ]]; then
  # if [ ! -d /Applications/Alacritty.app ]; then
  #   if ! command -V cargo > /dev/null 2>&1; then
  #     source "$HOME/.cargo/env"
  #   fi

  #   git clone --depth 1 https://github.com/alacritty/alacritty ~/.local/src/github.com/alacritty/alacritty
  #   cd ~/.local/src/github.com/alacritty/alacritty \
  #     && make app \
  #     && cp -r target/release/osx/Alacritty.app /Applications
  # fi

  if ! fc-list : family | grep 'SauceCodePro Nerd Font' > /dev/null 2>&1; then
    brew tap homebrew/cask-fonts
    brew install --cask font-sauce-code-pro-nerd-font
  fi
fi
