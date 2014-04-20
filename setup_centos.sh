#!/bin/bash

# vimbackup
[ ! -d ~/vimbackup ] && mkdir ~/vimbackup

# .vim folder
if [ ! -d ~/.vim ] ; then
	ln -s ~/dotfiles/vim ~/.vim
	git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
else 
	printf "%-30s already exists.\n" ~/.vim
fi

# oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
mv ~/.zshrc ~/.zshrc.backup
rm -f ~/.zshrc

# other dotfiles
DOT_FILES=( .ctags .gemrc .gitconfig .gitignore_global .gvimrc .irbrc .perltidyrc .profile .rubocop.yml .vimrc .zshrc .zshrc.alias .zshrc.custom .zshrc.linux .zshrc.osx )

for file in ${DOT_FILES[@]}
do
	if [ -L $HOME/$file ] ; then
		printf "%-30s already exists.\n" $file 
	else
		ln -s $HOME/dotfiles/$file $HOME/$file
		printf "Made symbolic link $HOME/$file\n" 
	fi
done

case ${OSTYPE} in
	darwin*)
		# Mac OS Settings ==============================================================
		;;
	linux*)
		# Linux Settings ===============================================================

		# tmux config
		TMUX_LINUX_CONFIG_FILE=".tmux.linux.1.9.conf"
		if [ -L $HOME/.tmux.conf ] ; then
			printf "%-30s already exists.\n" ".tmux.conf"
		else
			ln -s $HOME/dotfiles/$TMUX_LINUX_CONFIG_FILE $HOME/.tmux.conf
			printf "Made symbolic link $HOME/.tmux.conf\n" 
		fi

		;;
esac
