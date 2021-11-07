autoload -Uz compinit && compinit
fpath=($HOME/.zsh $fpath)

NL=$'\n'
DATE='%F{black}%K{white} 📆 %D{%a. %m/%d %H:%M:%S} %f%k'
K8S='%F{black}%K{white} $(prompt-k8s-current-context-and-namespace) %f%k' # もしログイン状態で表示/非表示にするなら空白も関数から返すようにする
GIT='$(prompt-git-current-branch)'
PROMPT='%F{black}%K{white} 💻 %n @ %m [ %. ] %f%k '${DATE}' '${K8S}' '${GIT}''${NL}'✏️  '

export JAVA_HOME=$(/usr/libexec/java_home -v11)
export JDK_HOME=${JAVA_HOME} # for coc-java
export PATH=$HOME/.nodebrew/current/bin:$PATH # for nodebrew
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export TERM=xterm-256color-italic
setopt prompt_subst

alias cat='ccat -G String="_brown_" -G Plaintext="overline" -G Punctuation="darkteal" -G Decimal="darkgreen" -G Keyword="green" -G Tag="faint"'
alias g='git'
alias vi='nvim'
alias vim='nvim'
alias ..2='cd ../../'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias ls='ls -lFG' # for mac
alias rm='rm -iv'
alias mv='mv -iv'
alias q='exit'
alias k='kubectl'

source ~/.zshrc.personal

source <(kubectl completion zsh)
complete -F __start_kubectl k

precmd() { print "" }

function prompt-git-current-branch
{
  local branch_name st branch_status

  if [ ! -e  .git ]; then; return ;fi

  branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  st=$(git status 2> /dev/null)

  if [[ -n $(echo ${st} | grep "^nothing to") ]]
  then
    branch_status="%F{black}%K{green} "
  elif [[ -n $(echo ${st} | grep "^Untracked files") ]]
  then
    branch_status="%F{black}%K{red} ?"
  elif [[ -n $(echo ${st} | grep "^Changes not staged for commit") ]]
  then
    branch_status="%F{black}%K{red} +"
  elif [[ -n $(echo ${st} | grep "^Changes to be committed") ]]
  then
    branch_status="%F{black}%K{yellow} !"
  elif [[ -n $(echo ${st} | grep "^rebase in progress") ]]
  then
    branch_status="%F{black}%K{red} !(no branch)"
  else
    branch_status="%F{black}%K{blue} "
  fi
  echo "${branch_status}[${branch_name}] %k%f"
}

function prompt-k8s-current-context-and-namespace
{
  local context namespace
  context=$(kubectl config get-contexts | grep \* | awk '{print $3}' | awk -F ':' '{print $2}')
  namespace=$(kubectl config get-contexts | grep \* | awk '{print $5}')
  echo "${context}:${namespace}"
}

function prompt-random-color
{
  local colors idxs color
  colors=('green' 'yellow' 'blue' 'magenta' 'cyan' 'white')
  idxs=($(shuf -i 1-$#colors -n 2 | tr '\n' ' '))
  echo "$colors[$idxs[1]]"
}
