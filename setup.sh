#!/bin/bash

DOT_FILES=( .ctags .gvimrc .perltidyrc .tmux.conf .vimrc .zshrc .zshrc.alias .zshrc.custom .zshrc.osx .zshrc.linux )

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done


# curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
[ ! -d ~/.oh-my-zsh ] && curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
