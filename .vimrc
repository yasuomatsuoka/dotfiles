" encoding
set enc=utf-8
set fenc=utf-8
set fencs=iso-2022-jp,utf-8,euc-jp,cp932


" basic
set backspace=indent,eol,start
set nobackup " バックアップ取らない
set autoread " 他で書き換えられたら自動で読み直す
set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
set vb t_vb= " ビープをならさない
set autoindent "改行で自動インデント
set statusline=%F%M%R%=code:%B%H%W "ステータスライン


" display
colorscheme desert
set wrap " 行末で折り返し
set showmatch " 括弧の対応をハイライト
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black
" 不可視文字の表示
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%


" tab
set tabstop=4 "表示時のスペース量
set softtabstop=4 " 入力時のスペース量
set shiftwidth=4 " 自動インデント幅
set expandtab " タブをスペースに展開
" syntax color
syntax on


" serach
set noignorecase " 大文字小文字無視
set smartcase " 大文字ではじめたら大文字小文字無視しない
set hlsearch " hilight


" completion
set wildmenu " コマンド補完を強化


" neobundle
set nocompatible " be iMproved
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
NeoBundle 'errormarker.vim'
NeoBundle 'sifue/smarty.vim'

filetype plugin indent on " required!
filetype indent on
syntax on


" keymapping
" emacs like keymap
inoremap <C-d> <Delete>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
" escape hilight
noremap <ESC><ESC> :nohlsearch<CR><ESC>
" pop for ctag
nnoremap <C-[> :pop<CR>
" fuzzyfinder.vim
nnoremap <silent> ff :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <silent> fb :<C-u>:FufBuffer!<CR>


" neocomplcache
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化


" ctags
set tags=/home/gree/tags


" for coffeescript
au BufNewFile,BufRead *.coffee set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.html set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
