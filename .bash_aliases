# bash aliases and shell functions.
alias dev2live='terminus site deploy --site=tallay --env=test --from=dev --note="Run from AjA mac" && terminus site deploy --site=tallay --env=live --from=test --note="Run from AjA mac"'

# grep search shortcut
ff () {
  echo "grep -lir \"$1\" *";
  grep -lir "$1" *;
}

# basic system commands
alias ll='ls -alF'
alias countlines='find . -type f -print0 | xargs -0 cat | wc -l'

# server & debugging commands
alias ss='sudo /etc/init.d/apache2 restart'
alias dd='tail -f /var/log/apache2/error.log'
alias dp='tail -f /Applications/MAMP/logs/php_error.log'
 
# general git shortcuts
alias gb='git checkout -b'
alias gp='git pull'
alias gs='git status'

# repo navigation commands
# config
REPO='/Users/orr587/github/baisong/openscholar'
DOCROOT='/Applications/MAMP/htdocs/docroot'
# additional locations
PROFILE="$DOCROOT/profiles/openscholar"
MODULES="$PROFILE/modules"
THEMES="$PROFILE/themes"
alias gm='clear && cd $MODULES && pwd && ll && git branch && gs'
alias gt='clear && cd $THEMES && pwd && ll && git branch && gs'
alias gd='clear && cd $DOCROOT && pwd && ll'
alias gp='clear && cd $PROFILE && pwd && ll && git branch && gs'
alias gr='clear && cd $REPO && pwd && ll && git branch && gs'

# git workflow shortcuts
## checks out and pulls the latest master branch.
## cpd = 'copy down' = 'checkout, pull dev'
alias cpd='git checkout SCHOLAR-3.x && git pull'
## pushes a topic branch to master
pcd () {
  CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`;
  echo "git push -u origin $CURRENT_BRANCH";
  git push -u origin $CURRENT_BRANCH;
}

# drush commands
alias cc='drush cc all'
alias wd='drush wd-show'
alias fry='drush fr -y'
alias fuy='drush fu -y'
alias eny='drush en -y'
alias disy='drush dis -y'
alias sqlc='/Applications/MAMP/Library/bin/mysql --host=localhost -uroot -proot os'

# drupal misc
alias coderf='php /Applications/MAMP/htdocs/docroot/sites/all/modules/coder/scripts/coder_format/coder_format.php'
alias osup='bash ~/bin/osup'
