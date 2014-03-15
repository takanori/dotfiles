#!/bin/bash

# Common Settings =============================================================

# vimbackup
[ ! -d ~/vimbackup ] && mkdir ~/vimbackup

# .vim folder
if [ ! -d ~/.vim ] ; then
	ln -s ~/dotfiles/vim ~/.vim
	git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
else 
	printf "%-30s already exists.\n" ~/.vim
	# echo '~/.vim already exists.'
fi


# oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
mv ~/.zshrc ~/.zshrc.backup
rm -f ~/.zshrc


# git settings
git config --global color.ui true
git config --global mergetool.keepBackup true
echo -e '\n#### Setup git account name and email by yourself ####'
echo '$ git config --global user.name "John Doe"'
echo -e '$ git config --global user.email johndoe@example.com\n'


# perl
if [ ! -d ~/perl5/perlbrew ] ; then
	curl -L http://install.perlbrew.pl | bash
	source ~/perl5/perlbrew/etc/bashrc
	perlbrew install --notest perl-5.18.2
	perlbrew switch perl-5.18.2
	perlbrew install-cpanm
	cpanm Carton Reply App::watcher
else
	printf "%-30s is already installed.\n" perlbrew 
fi


# other dotfiles
DOT_FILES=( .ctags .gemrc .gvimrc .irbrc .perltidyrc .profile .rubocop.yml .tmux.conf .vimrc .zshrc .zshrc.alias .zshrc.custom .zshrc.osx .zshrc.linux )

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

		# homebrew

		if [ ! which brew >/dev/null 2>&1 ] ; then
			ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
			export HOMEBREW_CASK_OPTS="--appdir=/Applications"
			brew bundle

			# brew update
			# HOMEBREW_FORMULAE=(ack coreutils ctags jq lynx openssl pyenv rbenv readline ruby-build terminal-notifier the_silver_searcher tig tree wget)
			# for $homebrew_formula in ${HOMEBREW_FORMULAE[@]}
			# do
			#     brew install $homebrew_formula
			# done

			# # ADDITIONAL_HOMEBREW_FORMULAE=(graphviz)
			# # for $additional_homebrew_formula in ${ADDITIONAL_HOMEBREW_FORMULAE[@]}
			# # do
			# #     brew install $additional_homebrew_formula
			# # done
		else	
			printf "%-30s is already installed.\n" homebrew
		fi
		;;
	linux*)
		# Linux Settings ===============================================================
		;;
esac
