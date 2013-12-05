#!/bin/bash

# vimbackup
[ ! -d ~/vimbackup ] && mkdir ~/vimbackup

# .vim folder
if [ ! -d ~/.vim ] ; then
	ln -s ~/dotfiles/vim ~/.vim
	git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
else 
	echo '~/.vim already exists.'
fi

# oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
rm -f ~/.zshrc

# diffconflicts for vimdiff
if [ ! -d ~/bin ] ; then
	mkdir ~/bin
else 
	echo '~/bin already exists.'
fi
ln -s ~/dotfiles/diffconflicts ~/bin/diffconflicts

# git settings
git config --global merge.tool diffconflicts
git config --global mergetool.diffconflicts.cmd 'diffconflicts vim $BASE $LOCAL $REMOTE $MERGED'
git config --global mergetool.diffconflicts.trustExitCode true
git config --global mergetool.diffconflicts.keepBackup false
git config --global color.ui true
git config --global mergetool.keepBackup true
echo -e '\n#### Setup git account name and email by yourself ####'
echo -e '$ git config --global user.name "John Doe"'
echo -e '$ git config --global user.email johndoe@example.com\n'

# other dotfiles
DOT_FILES=( .ctags .gvimrc .perltidyrc .profile .tmux.conf .vimrc .zshrc .zshrc.alias .zshrc.custom .zshrc.osx .zshrc.linux )

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

