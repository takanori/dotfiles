#!/bin/bash

# Common Settings =============================================================

# vimbackup
[ ! -d ~/vimbackup ] && mkdir ~/vimbackup

# Neovim config
if [ ! -d ~/.config/nvim ] ; then
    mkdir -p ~/.config
    ln -s ~/dotfiles/nvim ~/.config/nvim
else
    printf "%-30s already exists.\n" ~/.config/nvim
fi


# oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
mv ~/.zshrc ~/.zshrc.backup
rm -f ~/.zshrc


# other dotfiles
DOT_FILES=( .tigrc .ctags .gemrc .gitignore_global .gvimrc .irbrc .perlcriticrc .perltidyrc .profile .rubocop.yml .vimrc .ideavimrc .zshrc .zshrc.alias .zshrc.custom .zshrc.linux .zshrc.osx .zshrc.wsl .atcodertools.toml )

for file in ${DOT_FILES[@]}
do
	if [ -L $HOME/$file ] ; then
		printf "%-30s already exists.\n" $file 
	else
		ln -s $HOME/dotfiles/$file $HOME/$file
		printf "Made symbolic link $HOME/$file\n" 
	fi
done


# copy some dotfiles
DOT_FILES_TO_COPY=( .gitconfig )

for file_to_copy in ${DOT_FILES_TO_COPY[@]}
do
	if [ -f $HOME/$file_to_copy ] ; then
		printf "%-30s already exists.\n" $file_to_copy
	else
		cp $HOME/dotfiles/$file_to_copy $HOME/$file_to_copy
		printf "Made copy $HOME/$file_to_copy\n" 
	fi
done


# $HOME/bin
[ ! -d $HOME/bin ] && mkdir $HOME/bin
BIN_FILES=( homebrew-install-version.sh )

for bin_file in ${BIN_FILES[@]}
do
	if [ -L "$HOME/bin/$bin_file" ] ; then
		printf "%-30s already exists.\n" $bin_file
	else
		ln -s "$HOME/dotfiles/bin_files/$bin_file" "$HOME/bin/$bin_file"
		printf "Made symbolic link $HOME/bin/$bin_file\n"
	fi
done

# tmuxinator
[ ! -d $HOME/.tmuxinator ] && mkdir $HOME/.tmuxinator 
TMUXINATOR_FILES=( lifelog.yml )

for tmuxinator_file in ${TMUXINATOR_FILES[@]}
do
	if [ -L "$HOME/.tmuxinator/$tmuxinator_file" ] ; then
		printf "%-30s already exists.\n" $tmuxinator_file
	else
		ln -s "$HOME/dotfiles/tmuxinator/$tmuxinator_file" "$HOME/.tmuxinator/$tmuxinator_file"
		printf "Made symbolic link $HOME/.tmuxinator/$tmuxinator_file\n"
	fi
done


case ${OSTYPE} in
	darwin*)
		# Mac OS Settings ==============================================================

		# homebrew
		if [ ! which brew >/dev/null 2>&1 ] ; then
			ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
			# export HOMEBREW_CASK_OPTS="--appdir=/Applications"
			#brew bundle

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

		# tmux config
		TMUX_OSX_CONFIG_FILE=".tmux.osx.1.9.conf"
		if [ -L $HOME/.tmux.conf ] ; then
			printf "%-30s already exists.\n" ".tmux.conf"
		else
			ln -s $HOME/dotfiles/$TMUX_OSX_CONFIG_FILE $HOME/.tmux.conf
			printf "Made symbolic link $HOME/.tmux.conf\n" 
		fi

		
		# Others
		#Use current directory as default search scope in Finder
		defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

		# Show Path bar in Finder
		defaults write com.apple.finder ShowPathbar -bool true

		# Show Status bar in Finder
		defaults write com.apple.finder ShowStatusBar -bool true

		# Show hidden files
		defaults write com.apple.finder AppleShowAllFiles -bool true

		# Disable dashboard
		defaults write com.apple.dashboard mcx-disabled -boolean true

		;;
	linux*)
		# Linux Settings ===============================================================

                # Install packages on apt based systems (such as WSL)
                if command -v apt >/dev/null 2>&1 ; then
                        sudo apt update
                        sudo apt install -y \
                                ack-grep coreutils jq openssl \
                                shellcheck silversearcher-ag curl \
                                tig tree wget zsh locales build-essential
                fi

                # When running inside WSL, align Git settings with Windows
                if grep -qi Microsoft /proc/version 2>/dev/null; then
                        git config --global core.autocrlf true
                        git config --global core.filemode false
                        git config --global core.ignorecase true
                fi

                # Install the latest Neovim AppImage
                NVIM_APPIMAGE="$HOME/bin/nvim"
                if [ ! -f "$NVIM_APPIMAGE" ] ; then
                        nvim_arch="$(uname -m)"
                        case "$nvim_arch" in
                                x86_64)
                                        nvim_asset="nvim-linux-x86_64.appimage"
                                        ;;
                                aarch64|arm64)
                                        nvim_asset="nvim-linux-arm64.appimage"
                                        ;;
                                *)
                                        nvim_asset=""
                                        ;;
                        esac
                        if [ -n "$nvim_asset" ] && curl -L --fail "https://github.com/neovim/neovim/releases/latest/download/$nvim_asset" -o "$NVIM_APPIMAGE" ; then
                                chmod u+x "$NVIM_APPIMAGE"
                                printf "Installed latest Neovim to $NVIM_APPIMAGE\n"
                        else
                                printf "Failed to download Neovim AppImage\n" >&2
                                rm -f "$NVIM_APPIMAGE"
                        fi
                else
                        printf "%-30s already exists.\n" "$NVIM_APPIMAGE"
                fi

		# tmux config
		TMUX_LINUX_CONFIG_FILE=".tmux.linux.1.6.conf"
		if [ -L $HOME/.tmux.conf ] ; then
			printf "%-30s already exists.\n" ".tmux.conf"
		else
			ln -s $HOME/dotfiles/$TMUX_LINUX_CONFIG_FILE $HOME/.tmux.conf
			printf "Made symbolic link $HOME/.tmux.conf\n" 
		fi

		;;
esac
