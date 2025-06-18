
" Use Lua-based configuration when running under Neovim
if has('nvim')
  luafile ~/.config/nvim/init.lua
  finish
endif

set nocompatible
set number
syntax on
filetype plugin indent on
