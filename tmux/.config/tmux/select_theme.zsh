#!/bin/zsh

tmux split-window -v -p 32 'zsh -c "ls ~/.config/tmux/themes/*.tmux | fzf --prompt=\"Select tmux theme: \" --height=100% --layout=reverse --border --preview=\"bat {}\" --preview-window=right:60%:wrap | xargs -I {} tmux source-file {} && tmux display-message \"Loaded theme from {}\" "'
