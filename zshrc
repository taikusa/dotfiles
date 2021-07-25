fpath=($HOME/.zsh $fpath)

PROMPT='%F{black}%K{`prompt-random-color`} %n @ %m [ %. ] %f%k%B $%b '
RPROMPT='`rprompt-git-current-branch`'

export JAVA_HOME=$(/usr/libexec/java_home -v11)
export JDK_HOME=${JAVA_HOME} # for coc-java
export PATH=$HOME/.nodebrew/current/bin:$PATH # for nodebrew
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export TERM=xterm-256color-italic
export ZLE_PROMPT_INDENT=0
export ZLE_RPROMPT_INDENT=0
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

source ~/.zshrc.personal

autoload -Uz compinit && compinit

precmd() { print "" }

function rprompt-git-current-branch
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

function prompt-random-color
{
  local colors idxs color
  colors=('green' 'yellow' 'blue' 'magenta' 'cyan' 'white')
  idxs=($(shuf -i 1-$#colors -n 2 | tr '\n' ' '))
  echo "$colors[$idxs[1]]"
}
