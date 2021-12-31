source $HOME/.asdf/asdf.sh

function ghq-cd() {
  cd $(ghq list --full-path | sk)
}
