#!/bin/bash

[ ! -d ~/vimbackup ] && mkdir ~/vimbackup
[ ! -d ~/vim ] && mv ~/dotfiles/vim ~/.vim 

if [ ! -d ~/vim ] ; then
	cp -r ~/dotfiles/vim ~/.vim
	git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

[ ! -d ~/.oh-my-zsh ] && curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
rm -f ~/.zshrc

DOT_FILES=( .ctags .gvimrc .perltidyrc .tmux.conf .vimrc .zshrc .zshrc.alias .zshrc.custom .zshrc.osx .zshrc.linux )

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done


