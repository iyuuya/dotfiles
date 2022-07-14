export GPG_TTY=$(tty)

function ghq-cd() {
  cd $(ghq list --full-path | sk)
}

function sw() {
  if [ "$#" -ne 1 ]; then
    echo "sw: USER"
    return 1
  fi

  local user=$1
  ln -sf ~/.ssh/$user ~/.ssh/config
  ln -sf ~/.config/git/$user ~/.config/git/local
}

eval "$(direnv hook zsh)"

alias ls=exa
alias la="ls -a"
alias ll="ls -l"
alias dir="ls -la"

alias mux=tmuxinator
alias t=tmux
alias tls='tmux ls'
alias tat='tmux attach -t'

alias g=git
alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'
