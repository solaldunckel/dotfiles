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
  colored-man-pages
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

alias gww='gcc -Wall -Wextra -Werror'

# 42toolbox (https://github.com/alexandregv/42toolbox)
# Alias format: tb + script first letter
alias tbs="$HOME/42toolbox/init_session.sh"
alias tbd="$HOME/42toolbox/init_docker.sh"

# Valgrind in docker with custom compilation command
# Usage: valgrind_docker_custom "make re" "./ft_ls -l /tmp ~"
function valgrind_docker_custom () {
	docker run -it --rm --workdir $HOME --entrypoint sh -v $PWD:$HOME mooreryan/valgrind -c "$1 && valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all --show-reachable=yes $2"
}

# Valgrind in docker with default make
# Usage: valgrind_docker_make ./ft_ls -l /tmp ~
function valgrind_docker_make () {
	valgrind_docker_custom "make" "$*"
}

# Valgrind on macOS with fsanitize protection
# Usage: valgrind_macos ./ft_ls -l /tmp ~
# You must use "./" to specify executable file
function valgrind_macos ()
{
	for i in "$@"; do
		if [[ $i == ./* ]]; then
			cmd=$(nm -an $i | grep asan)
			if [[ $? == 0 ]]; then
				echo -e "\033[0;91mYou are trying to run valgrind but you compiled with -fsanitize. \033[1;31mNEVER do this on macOS\033[0;91m, this will crash you computer.\033[0;39m"
			else
				command valgrind $*
			fi
			break
		fi
	done
}

# Default alias on valgrind_macos
alias valgrind='valgrind_macos'
# $HOME/bin
export PATH=$PATH:$HOME/bin
