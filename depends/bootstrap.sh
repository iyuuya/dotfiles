#!/bin/zsh

SCRIPT_DIR="$(cd $(dirname $0); pwd)"
cd $SCRIPT_DIR

if [[ $OSTYPE == "darwin"* ]]; then
  brew bundle
elif [[ $(uname -a) == *"Debian"* ]]; then
  sudo apt-get update && \
  sudo apt-get install -y --no-install-recommends \
      automake autoconf bison build-essential libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev make \
    libreadline6-dev zlib1g-dev libncurses5-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev && \
  sudo apt-get clean && \
  sudo rm -rf /var/lib/apt/lists/*
fi

zsh $SCRIPT_DIR/rust.sh
zsh $SCRIPT_DIR/alacritty.sh
zsh $SCRIPT_DIR/asdf.sh
zsh $SCRIPT_DIR/neovim.sh
zsh $SCRIPT_DIR/tmuxinator.sh
