if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/github/baisong/dotfiles/.bash_aliases ]; then
  . ~/github/baisong/dotfiles/.bash_aliases
fi

export PIP_RESPECT_VIRTUALENV=true
export WORKON_HOME=$HOME/.venv
export EDITOR='subl -w'
 
source /usr/local/bin/virtualenvwrapper.sh
source ~/.resty/resty
source ~/.git-completion.bash
# Node.js needed vars
JOBS=2
 
##### CMD Aliases #####
alias ls="ls -G"
 
[[ -s "/Users/maumercado/.rvm/scripts/rvm" ]] && source "/Users/maumercado/.rvm/scripts/rvm"  # This loads RVM into a shell session.
 
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[1;34m\]"
CYAN="\[\033[0;36m\]"
PURPLE="\[\033[0;35m\]"
NO_COLOUR="\[\033[0m\]"
 
# Determine active Python virtualenv details.
function set_virtualenv () {
    if test -z "$VIRTUAL_ENV" ; then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="$CYAN(`basename \"$VIRTUAL_ENV\"`) "
    fi
}
 
function set_rvm_prompt {
  local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
  [ "$gemset" != "" ] && echo "(@$gemset) "
}
 
function parse_git_branch () {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' 
}
 
function set_git_branch {
  # Capture the output of the "git status" command.
 
    git_status="$(git status 2> /dev/null)"
    # Set color based on clean/staged/dirty.
    if [[ ${git_status} =~ "working directory clean" ]]; then
        B_STATE="${GREEN}"
    elif [[ ${git_status} =~ "Changes to be committed" ]] || [[ ${git_status} =~ "Changes not staged for commit" ]]; then
        B_STATE="${YELLOW}"
    else
        B_STATE="${RED}"
    fi
}
 
set_git_branch
set_virtualenv
 
PS1="$CYAN$(date +%H:%M)$NO_COLOUR ${PYTHON_VIRTUALENV}$PURPLE\$(set_rvm_prompt)$NO_COLOUR\u@\h:[\W]${B_STATE}\$(parse_git_branch)$NO_COLOUR\$ "
