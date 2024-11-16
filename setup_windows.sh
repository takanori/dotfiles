#!/bin/bash

# Common Settings =============================================================

# other dotfiles
DOT_FILES=(.tigrc .gitignore_global .ideavimrc)

for file in ${DOT_FILES[@]}; do
  if [ -L $HOME/$file ]; then
    printf "%-30s already exists.\n" $file
  else
    ln -s $HOME/dotfiles/$file $HOME/$file
    printf "Made symbolic link $HOME/$file\n"
  fi
done

# copy some dotfiles
DOT_FILES_TO_COPY=(.gitconfig)

for file_to_copy in ${DOT_FILES_TO_COPY[@]}; do
  if [ -f $HOME/$file_to_copy ]; then
    printf "%-30s already exists.\n" $file_to_copy
  else
    cp $HOME/dotfiles/$file_to_copy $HOME/$file_to_copy
    printf "Made copy $HOME/$file_to_copy\n"
  fi
done
