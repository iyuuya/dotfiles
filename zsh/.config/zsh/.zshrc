export GPG_TTY=$(tty)

function ghq-cd() {
  cd $(ghq list --full-path | sk)
}

function ghq-update-all() {
  ghq get -u -p $(ghq list)
}

function gw-cd() {
  worktrees=$(git worktree list) &&
  worktree=$(echo $worktrees | fzf +m) &&
  cd $(echo "$worktree" | awk '{print $1}')
}

function gco() {
  b=$(git branch | rg -v '[+*]' | tr -d '[:blank:]'| fzf +m --preview='echo "## Log ==========" && git log HEAD...{} -n 3 --date-order --reverse && echo "\n## Diff ==========" && git diff HEAD...{}') &&
  git checkout $b
}

function sw() {
  if [ "$#" -ne 1 ]; then
    echo "sw: USER"
    return 1
  fi

  local user=$1
  export P_USERNAME=$user
  ln -sf ~/.ssh/$user ~/.ssh/config
  ln -sf ~/.config/git/$user ~/.config/git/local
  ln -sf ~/.config/zsh/.zshenv.$user ~/.config/zsh/.zshenv.local
}

function enable-secret-mode() {
PROMPT='%D %* $ '
RPROMPT=
}

function disable-secret-mode() {
PROMPT='%F{green}%n%F{yellow}@%F{red}%M%f - %D %*
$ '
RPROMPT='[%~]'
}

function fzf-tmux-attach() {
  list=$(tmux ls)
  [ $? != 0 ] && return $?

  if [ -z $TMUX ]; then
    if [ $# -eq 1 ]; then
      tmux attach -t $1
    else
      selected=$(echo $list | fzf | tr -d : | awk '{ print $1 }') && tmux attach -t $selected
    fi
  else
    tmux choose-tree
  fi
}

eval "$(direnv hook zsh)"

if command -v eza > /dev/null 2>&1; then
  alias ls=eza
elif command -v exa > /dev/null 2>&1; then
  alias ls=exa
fi
alias la="ls -a"
alias ll="ls -l"
alias dir="ls -la"

alias mux=tmuxinator
alias t=tmux
alias tls='tmux ls'
alias tat=fzf-tmux-attach

alias g=git
alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'

alias less='/usr/share/vim/vim90/macros/less.sh'

alias -g G='| grep'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'

autoload -U compinit
compinit -i

function p_username() {
  echo -n "$P_USERNAME"
}

setopt PROMPT_SUBST
PROMPT='%F{green}$(p_username)%F{yellow}@%F{red}%M%f - %D %*
$ '
RPROMPT='[%~]'

if test -f $HOME/.config/zsh/.zshrc.local; then
  source "$HOME/.config/zsh/.zshrc.local"
fi
