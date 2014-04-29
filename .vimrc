" basic {{{
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,euc-jp,iso-2022-jp

set backspace=indent,eol,start
set nobackup
set autoread
set vb t_vb= 
set autoindent
set statusline=%F%M%R%=code:%B%H%W
set wildmenu " enhance command-completion
" }}}


" basic keymapping {{{
" emacs like keymap
inoremap <C-d> <Delete>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
" escape hilight
noremap <ESC><ESC> :nohlsearch<CR><ESC>
" pop for ctag
nnoremap <C-[> :pop<CR>
" }}}


" tab {{{
" anywhere SID
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
" set tabline
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
set showtabline=2 " show tabline everytime

" tab keymapping
" the prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" tab jump  t1 is jump to tab1, t2 is jump to tab2 , ...
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" tc create tab most right tab
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx close tab
map <silent> [Tag]x :tabclose<CR>
" tn next tab
map <silent> [Tag]n :tabnext<CR>
" tp previous tab
map <silent> [Tag]p :tabprevious<CR>
" }}}


" display {{{
syntax on
colorscheme desert
set wrap " return eol
set showmatch " hilight bracket

" show zenkaku
highlight ZenkakuSpace ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" show underline in current window
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
hi clear CursorLine
hi CursorLine cterm=underline gui=underline

" show invisible character format
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" do not stop BOL and EOL
set whichwrap=b,s,h,l,<,>,[,]

" tab setting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" }}}

" serach {{{
set noignorecase " ignore case-sensitivity
set smartcase " if BOL is a capital letter, enable case-sensitivity
set hlsearch
" }}}


" neobundle {{{
" http://vim-users.jp/2011/10/hack238/
set nocompatible " be iMproved
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim' " Unite file_mru
NeoBundle 'Shougo/vimproc' " for vimshell and vim-quickrun
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'scrooloose/syntastic' " syntax check at save
NeoBundle 'thinca/vim-quickrun' " \r 
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'Align'

filetype plugin on
filetype indent on
" }}}


" neocomplcache and neosnippet {{{
" enable in start
let g:neocomplcache_enable_at_startup = 1

" neosnippet keymapping
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" }}}


" unite {{{
" unite prefix key.
nnoremap [unite] <Nop>
nmap f [unite]

" unite general settings
" インサートモードで開始
let g:unite_enable_start_insert = 1
" 最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 50

" file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" unite keymapping
" 現在開いているファイルのディレクトリ下のファイル一覧。
" 開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
" ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
" ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
" uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
    " ESCでuniteを終了
    nmap <buffer> <ESC> <Plug>(unite_exit)
    " 入力モードのときjjでノーマルモードに移動
    imap <buffer> jj <Plug>(unite_insert_leave)
    " 入力モードのときctrl+wでpath単位で削除
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
    " ctrl+jで縦に分割して開く
    nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    " ctrl+jで横に分割して開く
    nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    " ctrl+oでその場所に開く
    nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
    inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
endfunction"}}}
" }}}


" for coffeescript {{{
au BufNewFile,BufRead *.coffee set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.html set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" }}}


" mac setting {{{
if filereadable(expand('~/.vimrc.mac'))
  source ~/.vimrc.mac
endif
" }}}


" local setting {{{
if filereadable(expand('~/.vimrc.mine'))
  source ~/.vimrc.mine
endif
" }}}
