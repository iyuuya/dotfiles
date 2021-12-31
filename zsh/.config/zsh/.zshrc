source $HOME/.asdf/asdf.sh

function ghq-cd() {
  cd $(ghq list --full-path | sk)
}

alias ls=exa
alias la="ls -a"
alias ll="ls -l"
alias dir="ls -la"
