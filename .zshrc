# If you come from bash you might have to change your $PATH.
export PATH=$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/sdunckel/.oh-my-zsh"

# ZSH Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
  git
  docker
  aws
  heroku
  #battery
  tmuxinator
  colored-man-pages
  asdf
)

source $ZSH/oh-my-zsh.sh

# Git add + git commit + git push
function push()
{
	make fclean
	find . -name ".DS_Store" -delete
	git add -A
	git commit -m $@
	git push
}


# $HOME/bin
export PATH=$PATH:$HOME/bin
