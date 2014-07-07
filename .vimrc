scriptencoding utf-8
set encoding=utf-8
set showmode
set scrolloff=10
" set clipboard=unnamed,autoselect
set clipboard+=unnamed

set backup
set backupdir=$HOME/vimbackup

set foldmethod=syntax
set foldlevel=20

" disable increment and decrement
nnoremap <C-A> <NOP>
nnoremap <C-X> <NOP>

let OSTYPE = system('uname')
if OSTYPE == "Darwin\n"
	augroup crontab
		autocmd! FileType crontab setlocal backupcopy=yes
	augroup END
endif

syntax on
set background=dark
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
colorscheme solarized

" Move cursor by display lines when wrapping
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" horizontal scroll in nowrap mode
nnoremap <C-L> 8zl
nnoremap <C-H> 8zh
 
" " swqp colon and semi colon
" nnoremap ; :
" nnoremap : ;

" Show encoding
set laststatus=2
"set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 

" Allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %

" Change indent continuously in visual mode
vnoremap < <gv
vnoremap > >gv

" Show em space
"全角スペースが強調表示されない場合、ここでscriptencodingを指定すると良い。
"scriptencoding cp932

"デフォルトのZenkakuSpaceを定義
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkred gui=underline guifg=darkred
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
    autocmd ColorScheme       * call ZenkakuSpace()
    " 全角スペースのハイライト指定
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

" " clipboard settings ========================================
" if OSTYPE == "Darwin\n"
	" vmap <Leader>c :w !pbcopy<CR><CR>
	" " MacVim can share the copied text with clipboard, so this setting is not necessary
" elseif OSTYPE == "Linux\n"
	" vmap <Leader>c :w !xsek -lb<CR><CR>
" endif

" tab editor settings =======================================
" imap <C-f> <ESC>:tabnext<CR>
" map  <C-f> :tabnext<CR>
" imap <C-b> <ESC>:tabprevious<CR>
" map  <C-b> :tabprevious<CR>
" "imap :e <ESC>:tabnew
" "map  :e :tabnew

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
" set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

"=============================================================
"=============================================================
"=============================================================

" NeoBundel Configulations ===================================

if has('vim_starting')
	set nocompatible               " Be iMproved
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" NeoBundle 'Shougo/neobundle.vim.git'

NeoBundle 'Shougo/vimproc', {
	  \ 'build' : {
	  \     'windows' : 'make -f make_mingw32.mak',
	  \     'cygwin' : 'make -f make_cygwin.mak',
	  \     'mac' : 'make -f make_mac.mak',
	  \     'unix' : 'make -f make_unix.mak',
	  \    },
	  \ }

function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if s:meet_neocomplete_requirements()
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundleFetch 'Shougo/neocomplcache.vim'
else
    NeoBundleFetch 'Shougo/neocomplete.vim'
    NeoBundle 'Shougo/neocomplcache.vim'
endif

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler.vim'
" NeoBundle 'Shougo/vimshell'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'Shougo/unite-outline'

" Syntax

NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'jelera/vim-javascript-syntax'
" NeoBundle 'marijnh/tern_for_vim', {
"   \ 'build': {
"   \   'others': 'npm install'
"   \}}
" NeoBundle 'pangloss/vim-javascript'
" NeoBundle 'mojo.vim'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails', { 'autoload' : {
      \ 'filetypes' : ['haml', 'ruby', 'eruby'] }}
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'groenewege/vim-less'
NeoBundle 'vim-scripts/applescript.vim'
" NeoBundle 'timcharper/textile.vim'
" Omni
NeoBundle 'c9s/perlomni.vim'
NeoBundleLazy 'vim-jp/cpp-vim', {
	\ 'autoload' : {'filetypes' : 'cpp'}
	\ }

" Formatter

NeoBundle 'Align'
NeoBundle 'SQLUtilities'
NeoBundle 'maksimr/vim-jsbeautify'

NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'thinca/vim-ref'
NeoBundle 'mojako/ref-sources.vim'
" NeoBundle 'hotchpotch/perldoc-vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'sudo.vim'
NeoBundle 'y-uuki/perl-local-lib-path.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundleLazy 'lambdalisue/vim-gista', {
    \ 'autoload': {
    \    'commands': ['Gista'],
    \    'mappings': '<Plug>(gista-',
    \    'unite_sources': 'gista',
    \}}

" NeoBundle 'wesleyche/Trinity'
" NeoBundle 'scrooloose/nerdtree.git' "nerdtree is included in trinity
NeoBundle 'wesleyche/SrcExpl'
NeoBundle 'thinca/vim-qfreplace'
"NeoBundle 'taglist.vim' "Download from http://www.vim.org/scripts/download_script.php?src_id=19574
NeoBundle "majutsushi/tagbar"
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tell-k/vim-browsereload-mac'
NeoBundle 'tpope/vim-surround'
" NeoBundle 'mattn/zencoding-vim' " Moved to emmet-vim
NeoBundle 'mattn/emmet-vim'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'saihoooooooo/vim-textobj-space'
NeoBundle 'Raimondi/delimitMate' " delimitMate breaks the redo features
NeoBundle 'tpope/vim-endwise' " vim-endwise must be placed after delimitMate
NeoBundle 'YankRing.vim'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'xolox/vim-session', {
            \ 'depends' : 'xolox/vim-misc',
          \ }

if OSTYPE == "Darwin\n"
	NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
endif

" Color Scheme
NeoBundle 'altercation/vim-colors-solarized'

filetype plugin indent on     " Required!

NeoBundleCheck


" neocomplete and neocomplecache configulations ================================

if s:meet_neocomplete_requirements()
    " 新しく追加した neocomplete の設定
	
	" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplete.
	let g:neocomplete#enable_at_startup = 1
	" Use smartcase.
	let g:neocomplete#enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplete#sources#syntax#min_keyword_length = 3
	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

	" Define dictionary.
	let g:neocomplete#sources#dictionary#dictionaries = {
		\ 'default'   : '',
		\ 'vimshell'  : $HOME.'/.vimshell_hist',
		\ 'perl'      : $HOME . '/.vim/dict/perl.dict',
		\ 'scheme'    : $HOME.'/.gosh_completions'
			\ }

	" Define keyword.
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplete#undo_completion()
	inoremap <expr><C-l>     neocomplete#complete_common_string()

	" " Recommended key-mappings.
	" " <CR>: close popup and save indent.
	" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	" function! s:my_cr_function()
	  " return neocomplete#smart_close_popup() . "\<CR>"
	  " " For no inserting <CR> key.
	  " "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
	" endfunction

	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
	" " <C-h>, <BS>: close popup and delete backword char.
	" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
	" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
	" inoremap <expr><C-y>  neocomplete#close_popup()
	" inoremap <expr><C-e>  neocomplete#cancel_popup()
	" " Close popup by <Space>.
	" "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

	" For cursor moving in insert mode(Not recommended)
	"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
	"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
	"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
	"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
	" Or set this.
	"let g:neocomplete#enable_cursor_hold_i = 1
	" Or set this.
	"let g:neocomplete#enable_insert_char_pre = 1

	" AutoComplPop like behavior.
	"let g:neocomplete#enable_auto_select = 1

	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplete#enable_auto_select = 1
	"let g:neocomplete#disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
	
	
	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplete#sources#omni#input_patterns')
	  let g:neocomplete#sources#omni#input_patterns = {}
	endif
	let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
	let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

	" For perlomni.vim setting.
	" https://github.com/c9s/perlomni.vim
	let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
else
    " 今までの neocomplcache の設定

	"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplcache.
	let g:neocomplcache_enable_at_startup = 1
	" Use smartcase.
	let g:neocomplcache_enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplcache_min_syntax_length = 3
	let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

	" Enable heavy features.
	" Use camel case completion.
	"let g:neocomplcache_enable_camel_case_completion = 1
	" Use underbar completion.
	"let g:neocomplcache_enable_underbar_completion = 1

	" Define dictionary.
	let g:neocomplcache_dictionary_filetype_lists = {
		\ 'default' : '',
		\ 'vimshell' : $HOME.'/.vimshell_hist',
		\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

	" Define keyword.
	if !exists('g:neocomplcache_keyword_patterns')
		let g:neocomplcache_keyword_patterns = {}
	endif
	let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplcache#undo_completion()
	inoremap <expr><C-l>     neocomplcache#complete_common_string()

	" " Recommended key-mappings.
	" " <CR>: close popup and save indent.
	" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	" function! s:my_cr_function()
	  " return neocomplcache#smart_close_popup() . "\<CR>"
	  " " For no inserting <CR> key.
	  " "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
	" endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplcache#close_popup()
	inoremap <expr><C-e>  neocomplcache#cancel_popup()
	" Close popup by <Space>.
	"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

	" For cursor moving in insert mode(Not recommended)
	"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
	"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
	"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
	"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
	" Or set this.
	"let g:neocomplcache_enable_cursor_hold_i = 1
	" Or set this.
	"let g:neocomplcache_enable_insert_char_pre = 1

	" AutoComplPop like behavior.
	"let g:neocomplcache_enable_auto_select = 1

	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplcache_enable_auto_select = 1
	"let g:neocomplcache_disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplcache_omni_patterns')
	  let g:neocomplcache_omni_patterns = {}
	endif
	let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

	" For perlomni.vim setting.
	" https://github.com/c9s/perlomni.vim
	let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

endif


" neosnippet settings ======================================
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


" ==========================================================
" Unite ====================================================
" ==========================================================
let g:unite_winwidth = 40
call unite#custom#default_action('directory', 'vimfiler')
autocmd FileType unite call unite#custom#default_action('directory', 'vimfiler')

" let g:unite_enable_start_insert = 1
" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

nnoremap <Leader>uu :Unite 
nnoremap <silent> <Leader>ut  :<C-u>Unite tab<CR>
nnoremap <silent> <Leader>uf  :<C-u>Unite file_rec/async:!<CR>

nnoremap <silent> <Leader>ub  :<C-u>Unite buffer_tab<CR>
nnoremap <silent> <Leader>um  :<C-u>Unite bookmark<CR>
nnoremap <silent> <Leader>ur  :<C-u>Unite file_mru<CR>
nnoremap <silent> <Leader>uo  :<C-u>Unite -vertical outline<CR>
nnoremap <silent> <Leader>dpm :<C-u>Unite ref/perldoc -default-action=tabopen<CR>
nnoremap          <Leader>dpf :<C-u>Ref perldoc -f<Space>
nnoremap          <Leader>dpc :<C-u>Ref cpan<Space>

" unite-grep settings ======================================

" grep検索
nnoremap <silent> <Leader>gg  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> <Leader>gw :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>

" grep検索結果の再呼出
nnoremap <silent> <Leader>ga  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
" if executable('ag')
"   let g:unite_source_grep_command = 'ag'
"   let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
"   let g:unite_source_grep_recursive_opt = ''
" endif

" ==========================================================
" ==========================================================
" ==========================================================


" gundo settings ===========================================
nnoremap <silent> <Leader>gu :<C-u>GundoToggle<CR>


" easymotion settings ======================================
let g:EasyMotion_do_mapping = 0 "Disable default mappings
nmap s <Plug>(easymotion-s2)

" vim-gista settings =======================================
let g:gista#github_user = 'takanori'
let g:gista#post_private = 1

" vim-fugitive settings ====================================
nnoremap <silent> <Leader>vs :<C-u>Gstatus<CR>
" nnoremap <silent> <Leader>vr :<C-u>Gread<CR>
" nnoremap <silent> <Leader>vw :<C-u>Gwrite<CR>
nnoremap <silent> <Leader>vc :<C-u>Gcommit<CR>
nnoremap <silent> <Leader>vd :<C-u>Gdiff<CR>
nnoremap <silent> <Leader>vu :<C-u>diffupdate<CR>
nnoremap <silent> <Leader>2 :<C-u>diffget //2 \| diffupdate<CR>
nnoremap <silent> <Leader>3 :<C-u>diffget //3 \| diffupdate<CR>

" filetype settings ========================================

augroup filetypedetectgroup
	autocmd BufNewFile,BufRead *.tx           set filetype=html 
	autocmd BufNewFile,BufRead *.tt           set filetype=html 
	" autocmd BufNewFile,BufRead *.tx      set filetype=xslt
	" autocmd BufNewFile,BufRead *.tt      set filetype=tt2html
	"" Changing filetype to tt2html will stop autoindent and completion
	autocmd BufNewFile,BufRead *.psgi         set filetype=perl
	autocmd BufNewFile,BufRead cpanfile       set filetype=perl
	autocmd BufNewFile,BufRead *.t            set filetype=perl
	autocmd BufNewFile,BufRead *.fcgi         set filetype=perl
	autocmd BufNewFile,BufRead *.applescript  set filetype=applescript
augroup END


" filetypeごとのタブ幅やラッピングの指定

autocmd FileType javascript   set nowrap tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType perl         set nowrap tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType cs           set nowrap tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType mkd          set nowrap tabstop=4 shiftwidth=4 softtabstop=4 expandtab

autocmd FileType html         set nowrap tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType tt2html      set nowrap tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType sql          set nowrap tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType ruby         set nowrap tabstop=2 shiftwidth=2 softtabstop=2 expandtab


" syntastic settings =======================================
let g:syntastic_filetype_map = { 'tt2html':    'html',
							   \ 'tx':         'html'}
let g:syntastic_ruby_checkers = ['rubocop']

let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'perlcritic']

" tern_for_vim settings ===================================
" let g:tern_show_argument_hints=1

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
"set shiftwidth=2
"set softtabstop=2
"set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
set shiftwidth=4
set tabstop=4



" delimiteMate settings ======================================
let g:delimitMate_matchpairs = "(:),[:],{:}"
let g:delimitMate_expand_cr = 1
" let g:delimitMate_expand_space = 1


" vim-markdown and Kobito settings =========================
let g:vim_markdown_folding_disabled=1

function! s:open_kobito(...)
    if a:0 == 0
        call system('open -a Kobito '.expand('%:p'))
    else
        call system('open -a Kobito '.join(a:000, ' '))
    endif
endfunction

" 引数のファイル(複数指定可)を Kobitoで開く
" （引数無しのときはカレントバッファを開く
command! -nargs=* Kobito call s:open_kobito(<f-args>)
" Kobito を閉じる
command! -nargs=0 KobitoClose call system("osascript -e 'tell application \"Kobito\" to quit'")
" Kobito にフォーカスを移す
command! -nargs=0 KobitoFocus call system("osascript -e 'tell application \"Kobito\" to activate'")



" ==========================================================
" Formatter settings
" ==========================================================

" Align.vim  ===============================================
let g:Align_xstrlen=3


" perl tidy ================================================
nnoremap <Leader>fp <Esc>:%! perltidy<CR>
vnoremap <Leader>fp <Esc>:'<,'>! perltidy<CR>


" JsBeautify settings  =====================================
autocmd FileType javascript noremap <Leader>fj :call JsBeautify()<cr>
autocmd FileType html       noremap <Leader>fh :call HtmlBeautify()<cr>
autocmd FileType css        noremap <Leader>fc :call CSSBeautify()<cr>


" SQLUtilities settings  ===================================
noremap <Leader>fs :SQLUFormatter<cr>


" " vimshell settings ======================================
" nnoremap <silent> vs :VimShell<CR>
" nnoremap <silent> vp :VimShellPop<CR>
" nnoremap <silent> vt :VimShellTab<CR>
" " nnoremap <silent> vsc :VimShellCreate<CR>
" let g:vimshell_prompt_expr = 'getcwd()." > "'
" let g:vimshell_prompt_pattern = '^\f\+ > '
" " let g:vimshell_enable_smart_case = 1


" vimfiler settings ========================================
" nnoremap <C-e> :VimFilerExplorer<Cr>
nnoremap <C-e> :VimFiler<Cr>
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_as_default_explorer = 1
" let g:vimfiler_split_rule = "belowright"


" tagbar settings ========================================
set tags=tags,~/perl5/perlbrew/perls/perl-5.18.1/lib/tags
let g:tagbar_autoclose = 1
nnoremap <silent> <Leader>b :TagbarToggle<CR> " 'b'ar


" quickrun settings ========================================
nmap <Leader>r <plug>(quickrun)
let g:quickrun_config = {
	\ "_" : {
	\ 	"runner" : "vimproc",
	\ 	"outputter/buffer/split" : ":rightbelow 16sp",
	\	"outputter" : "buffer",
	\ },
	\}


" SrcExpl settings =========================================
" // The switch of the Source Explorer 
nmap <Leader>e :SrcExplToggle<CR> 
" nmap <F8> :SrcExplToggle<CR> 

" // Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 8

" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 1

" // Set "Enter" key to jump into the exact definition context 
" let g:SrcExpl_jumpKey = "<ENTER>" 

" // Set "Space" key for back from the definition context 
" let g:SrcExpl_gobackKey = "<SPACE>" 

" // In order to avoid conflicts, the Source Explorer should know what plugins
" // except itself are using buffers. And you need add their buffer names into
" // below listaccording to the command ":buffers!"
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_" 
    \ ] 

" // Enable/Disable the local definition searching, and note that this is not 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
" // It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 1 

" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" // create/update the tags file 
let g:SrcExpl_updateTagsCmd = "`brew --prefix`/bin/ctags --sort=foldcase -R ." 

" // Set "<F5>" key for updating the tags file artificially 
let g:SrcExpl_updateTagsKey = "<F5>" 

" // Set "<F3>" key for displaying the previous definition in the jump list 
" let g:SrcExpl_prevDefKey = "<F3>" 

" // Set "<F4>" key for displaying the next definition in the jump list 
" let g:SrcExpl_nextDefKey = "<F4>" 

" quickfix grep settings ===================================
autocmd QuickFixCmdPost *grep* cwindow

" nerdcommenter settings ===================================
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
" nmap <C-C> <Plug>NERDCommenterToggle
" vmap <C-C> <Plug>NERDCommenterToggle
nmap <C-C> <Plug>NERDCommenterAlignLeft
nmap <C-X> <Plug>NERDCommenterUncomment
vmap <C-C> <Plug>NERDCommenterAlignLeft
vmap <C-X> <Plug>NERDCommenterUncomment


" YankRing settings ========================================
nnoremap <silent> <leader>y :YRShow<CR>
let g:yankring_window_height = 20 


" vim-over settings ========================================
nnoremap <silent> <Leader>o :OverCommandLine<CR>
vnoremap <silent> <Leader>o :OverCommandLine<CR>


" vim-session settings =====================================
" 現在のディレクトリ直下の .vimsessions/ を取得 
let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
" 存在すれば
if isdirectory(s:local_session_directory)
  " session保存ディレクトリをそのディレクトリの設定
  let g:session_directory = s:local_session_directory
  " vimを辞める時に自動保存
  " let g:session_autosave = 'yes'
  let g:session_autosave = 'no'
  " 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
  let g:session_autoload = 'yes'
  " 1分間に1回自動保存
  " let g:session_autosave_periodic = 1
else
  let g:session_autosave = 'no'
  let g:session_autoload = 'no'
endif
unlet s:local_session_directory

" vim-latex settings =================================== {{{
" let g:tex_fold_enabled=0
let g:tex_fast= ""
" let g:tex_fast= "bcprsSvV"
" let g:tex_fast= "m"

filetype plugin on
filetype indent on
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Imap_UsePlaceHolders = 1
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
let g:Tex_CompileRule_pdf = '/usr/texbin/ptex2pdf -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/ptex2pdf -l -u -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/dvipdfmx $*.dvi'
"let g:Tex_CompileRule_pdf = '/usr/local/bin/ps2pdf $*.ps'
let g:Tex_CompileRule_ps = '/usr/texbin/dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_dvi = '/usr/texbin/platex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_dvi = '/usr/texbin/uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_BibtexFlavor = '/usr/texbin/pbibtex'
"let g:Tex_BibtexFlavor = '/usr/texbin/upbibtex'
"let g:Tex_BibtexFlavor = '/usr/texbin/bibtex'
"let g:Tex_BibtexFlavor = '/usr/texbin/bibtexu'
let g:Tex_MakeIndexFlavor = '/usr/texbin/mendex $*.idx'
"let g:Tex_MakeIndexFlavor = '/usr/texbin/makeindex $*.idx'
"let g:Tex_MakeIndexFlavor = '/usr/texbin/texindy $*.idx'
let g:Tex_UseEditorSettingInDVIViewer = 1
let g:Tex_ViewRule_pdf = '/usr/bin/open -a Preview.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a Skim.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a TeXShop.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a TeXworks.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a Firefox.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a "Adobe Reader.app"'
let g:Tex_ViewRule_ps = '/usr/bin/open'
let g:Tex_ViewRule_dvi = '/usr/bin/open'

let g:Tex_AutoFolding = 0
" }}} 

" perl-local-lib-path settings ===================================
" g:perl_local_lib_path = "vendor/lib"
autocmd FileType perl PerlLocalLibPath


" Dash.app settings ==============================================
"" ファイルタイプを指定する場合
" function! s:dash(...)
"     if len(a:000) == 1 && len(a:1) == 0
"         echomsg 'No keyword'
"     else
"         let ft = &filetype
"         if &filetype == 'python'
"             let ft = ft.'2'
"         elseif  &filetype == 'javascript'
"             let ft = 'js'
"         endif
"         let ft = ft.':'
"         let word = len(a:000) == 0 ? input('Keyword: ', ft.expand('<cword>')) : ft.join(a:000, ' ')
"         call system(printf("open dash://'%s'", word))
"     endif
" endfunction

function! s:dash(...)
  let word = len(a:000) == 0 ? input('Dash search: ') : a:1
  call system(printf("open dash://'%s'", word))
endfunction
command! -nargs=? Dash call <SID>dash(<f-args>)

nnoremap <Leader>da :call <SID>dash(expand('<cword>'))<CR>


" vim-ref settings ===============================================
let g:ref_open = 'tabnew'


" vim-ref webdict settings =======================================
"http://eow.alc.co.jp/search?q=preference
let g:ref_source_webdict_sites = {
\   'je': {
\     'url': 'http://eow.alc.co.jp/search?q=%s',
\   },
\   'ej': {
\     'url': 'http://eow.alc.co.jp/search?q=%s',
\   },
\ }
 
"デフォルトサイト
let g:ref_source_webdict_sites.default = 'ej'
 
"出力に対するフィルタ。最初の数行を削除
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[38 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[38 :], "\n")
endfunction

nnoremap <Leader>ddi :<C-u>Ref webdict ej<Space>
nnoremap <Leader>ddh :call ref#jump('normal', 'webdict', 'ej')<CR>

" weblio english settings ========================================

function! s:open_weblio(word)
	call openbrowser#open('http://ejje.weblio.jp/content/' . a:word)
endfunction

function! s:open_weblio_under_cursor()
	call openbrowser#open('http://ejje.weblio.jp/content/' . expand('<cword>'))
endfunction

command! -nargs=1 OpenWeblio call s:open_weblio(<f-args>)
command! -nargs=0 OpenWeblioUnderCursor call s:open_weblio_under_cursor()

nnoremap <Leader>dpri :OpenWeblio<Space>
nnoremap <Leader>dprh :OpenWeblioUnderCursor<CR>



" vim-browsereload-mac settings =================================
let g:returnApp = "iTerm"


" Checking typo. ================================================
" http://d.hatena.ne.jp/tyru/20130419/avoid_tyop （partially amended）
autocmd BufWriteCmd :*,*[,*] call s:write_check_typo(expand('<afile>'))
function! s:write_check_typo(file)
    let prompt = "possible typo: really want to write to '" . a:file . "'?(y/n):"
    let input = input(prompt)
    if input =~? '^y\(es\)\=$'
        execute 'write'.(v:cmdbang ? '!' : '') a:file
    endif
endfunction

" mark settings ==================================================
" マーク設定 : {{{

augroup MyAutoCmd
	autocmd!
augroup END

" 基本マップ
nnoremap [Mark] <Nop>
nmap m [Mark]

" 現在位置をマーク
if !exists('g:markrement_char')
    let g:markrement_char = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
nnoremap <silent>[Mark]m :<C-u>call <SID>AutoMarkrement()<CR>
function! s:AutoMarkrement()
    if !exists('b:markrement_pos')
        let b:markrement_pos = 0
    else
        let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
    endif
    execute 'mark' g:markrement_char[b:markrement_pos]
    echo 'marked' g:markrement_char[b:markrement_pos]
endfunction

" 次/前のマーク
nnoremap [Mark]n ]`
nnoremap [Mark]p [`

" 一覧表示
nnoremap [Mark]l :<C-u>marks<CR>

" 前回終了位置に移動
autocmd MyAutoCmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | exe 'normal g`"' | endif

" バッファ読み込み時にマークを初期化
autocmd MyAutoCmd BufReadPost * delmarks!

" }}}




set nocompatible
" One of the most important options to activate. Allows you to switch from an unsaved buffer without saving it first. Also allows you to keep an undo history for multiple files. Vim will complain if you try to quit without saving, and swap files will keep you safe if your computer crashes.
set hidden
" Better command-line completion
set wildmenu
" Show partial commands in the last line of the screen
set showcmd
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the mapping of <C-L> below)
set incsearch
set hlsearch
" Modelines have historically been a source of security vulnerabilities.  As such, it may be a good idea to disable them and use the securemodelines script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
"------------------------------------------------------------
set ignorecase
set smartcase
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
set autoindent
" Stop certain movements from always going to the first character of a line.  While this behaviour deviates from that of Vi, it does what most users coming from other editors would expect.
set nostartofline
" Display the cursor position on the last line of the screen or in the status line of a window
"set ruler
" Instead of failing a command because of unsaved changes, instead raise a dialogue asking if you wish to save changed files.
set confirm
" Disable visual bell and beep
set visualbell
set t_vb=
" Enable use of the mouse for all modes
set mouse=a
" Set the command window height to 2 lines, to avoid many cases of having to "press <Enter> to continue"
set cmdheight=2
" Display line numbers on the left
set number
" toggle number
nnoremap <Leader>n :set invnumber<CR>
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F12>

" Attempt to determine the type of a file based on its name and possibly its
" contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy, which is the default
map Y y$
" Map <C-K> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-K> :nohl<CR><C-L>

set cindent

" Disable auto newline
set textwidth=0
autocmd FileType text setlocal textwidth=0
