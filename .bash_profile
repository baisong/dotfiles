if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/github/baisong/dotfiles/.bash_aliases ]; then
  . ~/github/baisong/dotfiles/.bash_aliases
fi

export PIP_RESPECT_VIRTUALENV=true
export WORKON_HOME=$HOME/.venv
export EDITOR='subl -w'
 
#source /usr/local/bin/virtualenvwrapper.sh
#source ~/.resty/resty
#source ~/.git-completion.bash
# Node.js needed vars
#JOBS=2
 
##### CMD Aliases #####
alias gb='git checkout -b'
alias l='ls -a1F'
alias ll='ls -alF'
alias gpgp='git pull --rebase && git push'
alias gcm='git checkout master && git pull --rebase'
alias gs='git status'
alias gd='git diff HEAD^ HEAD'
alias gl='git log --pretty=oneline'
alias glg='git log --oneline --all --graph --decorate'
alias gls='git log --stat'

# Example
# >  confirm "Delete file2."
# >  if [ $? -eq 0 ]
# >  then
# >      echo Another file deleted
# >  fi
function confirm()
{
    if [ $PROMPT -eq 0 ]
    then
        return 0
    fi
    echo -n "$@"
    echo ""
    echo "Continue? (y/n) "
    read -e answer
    for response in y Y yes YES Yes Sure sure SURE OK ok Ok
    do
        if [ "_$answer" == "_$response" ]
        then
            return 0
        fi
    done
 
    # Any answer other than the list above is considerred a "no" answer
    return 1
}

function confirmcommit()
{
    #if [ $PROMPT -eq 0 ]
    #then
    #    return 0
    #fi
    echo -n "$@"
    echo " "
    read -e answer
    #echo "You wrote: _$answer"
    #if [ $# -eq 0 ]
    if [ -z "$answer" ]
    then
        return 0
    fi
 
    # Any answer other than the list above is considerred a "no" answer
    echo "git commit -m \"$answer\""
    git commit -m "$answer"
    return 1
}

function ga()
{
	      echo "git add ."
	      git add .
        # @TODO actually detect when there are no changes.
        git update-index -q --refresh
        #git ls-files --other --error-unmatch --exclude-standard . >/dev/null 2>&1; ec=$?
        git status --porcelain >/dev/null 2>&1; ec=$?
        if test "$ec" = 0; then
            git status
            confirmcommit "Enter commit message or press [Enter] to do nothing."
            if [ $? -eq 0 ]
            then
                echo "Cool. No action taken."
            else
                echo "Committed."
            fi
        elif test "$ec" = 1; then
            echo No untracked files.
        else
            echo error from ls-files
        fi
}

# @TODO
function up()
{
    branch_name=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,') ||
    branch_name="(unnamed branch)"
    echo "[#] Merging and pushing branch $branch_name..."
    echo "[1] git checkout master"
    git checkout master
    echo "[2] git pull"
    git pull
    echo "[3] git merge --squash $branch_name"
    git merge --squash $branch_name
    # @TODO detect when there's a conflict.
    echo "[4] git commit -m \"$1\""
    git commit -m "$1"
    echo "[5] git pull --rebase"
    git pull --rebase
    echo "[6] git push"
    git push
}

function gam()
{
    git add .
    git commit -m "$1"
}

function inch()
{
    echo git diff HEAD
    git diff HEAD --exit-code
    echo "git status"
    git status
    echo "git add ."
    git add .
    echo "git commit -m \"Work-in-progress: $1\""
    git commit -m "Work-in-progress: $1"
    echo git pull
    git pull
    echo git push -u
    git push -u
    echo "git status"
    git status
}

function wip()
{
    gam "Work in progress"
    git checkout master
    git status
}

function combine()
{
    branch_name=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,') ||
    branch_name="(unnamed branch)"
    echo "[+] Merging master into branch: $branch_name"
    sleep 1
    echo "[+] git checkout master"
    git checkout master
    echo "[+] git pull"
    git pull
    echo "[+] git checkout $branch_name"
    git checkout $branch_name
    echo "[+] git merge master"
    git merge master
    echo "[+] git status"
}

function whatbranch()
{
    branch_name=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,') ||
    branch_name="(unnamed branch)"
    echo branch: $branch_name
}
 
#[[ -s "/Users/maumercado/.rvm/scripts/rvm" ]] && source "/Users/maumercado/.rvm/scripts/rvm"  # This loads RVM into a shell session.
 
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
#set_virtualenv
 
PS1="$CYAN$(date +%H:%M)$NO_COLOUR ${PYTHON_VIRTUALENV}$PURPLE\$(set_rvm_prompt)$NO_COLOUR\u@\h:[\W]${B_STATE}\$(parse_git_branch)$NO_COLOUR\$ "
