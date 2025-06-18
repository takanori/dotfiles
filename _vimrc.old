scriptencoding utf-8
set encoding=utf-8
set showmode
set scrolloff=10
" set clipboard=unnamed,autoselect
set clipboard+=unnamed

set completeopt-=preview

set backup
set backupdir=$HOME/vimbackup

set foldmethod=syntax
set foldlevel=20

" disable increment and decrement
nnoremap <C-A> <NOP>
nnoremap <C-X> <NOP>

if executable('zenhan')
  autocmd InsertLeave * :call system('zenhan 0')
  autocmd CmdlineLeave * :call system('zenhan 0')
endif
