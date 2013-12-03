#!/bin/bash

[ ! -d ~/vimbackup ] && mkdir ~/vimbackup

if [ ! -d ~/.vim ] ; then
	ln -s ~/dotfiles/vim ~/.vim
	git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
else 
	echo '~/.vim already exists.'
fi

[ ! -d ~/.oh-my-zsh ] && curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
rm -f ~/.zshrc

DOT_FILES=( .ctags .gvimrc .perltidyrc .profile .tmux.conf .vimrc .zshrc .zshrc.alias .zshrc.custom .zshrc.osx .zshrc.linux )

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done


