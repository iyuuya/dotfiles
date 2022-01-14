export GPG_TTY=$(tty)

function ghq-cd() {
  cd $(ghq list --full-path | sk)
}

alias ls=exa
alias la="ls -a"
alias ll="ls -l"
alias dir="ls -la"
alias mux=tmuxinator
alias t=tmux
alias tls='tmux ls'
alias tat='tmux attach -t'
