" macvim-kaoriya http://code.google.com/p/macvim-kaoriya/

colorscheme desert

" encoding
set enc=utf-8
set fenc=utf-8
set fencs=iso-2022-jp,utf-8,euc-jp,cp932

" basic
set nobackup " バックアップ取らない
set autoread " 他で書き換えられたら自動で読み直す
set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
set vb t_vb= " ビープをならさない

" display
set number " 行番号表示
set wrap " 行末で折り返し
set showmatch " 括弧の対応をハイライト
" 全角スペースの表示
 highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
 match ZenkakuSpace /　/

" https://github.com/yuroyoro/dotfiles/blob/master/.vimrc.apperance
" カーソル行をハイライト
" set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" yankでクリップボードに渡す
if has('mac') && !has('gui')
    nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
    vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
    nnoremap <silent> <Space>p :r !pbpaste<CR>
    vnoremap <silent> <Space>p :r !pbpaste<CR>
" GVim(Mac & Win)
else
    noremap <Space>y "+y
    noremap <Space>p "+p
endif

" tab
:set tabstop=4 "表示時のスペース量
:set softtabstop=4 " 入力時のスペース量
:set shiftwidth=4 " 自動インデント幅
:set expandtab " タブをスペースに展開

" syntax color
syntax on

" serach
:set noignorecase " 大文字小文字無視
:set smartcase " 大文字ではじめたら大文字小文字無視しない

" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" vundleで管理するプラグインの列挙
Bundle 'gmarik/vundle'
Bundle 'gtags.vim'
" github内のプラグイン

" www.vim.org内のプラグイン

" gitリポジトリにあるプラグイン

filetype plugin indent on
" ここまでVundle

" completion
set wildmenu " コマンド補完を強化

" keymapping
" Escの2回押しでハイライト消去
noremap <ESC><ESC> ;nohlsearch<CR><ESC>

" emacs 移動をライクに。http://d.hatena.ne.jp/LukeSilvia/20090906/p1
inoremap <C-d> <Delete>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>

" gtags
" " 検索結果Windowを閉じる
 nnoremap <C-q> <C-w><C-w><C-w>q
" " Grep 準備
 nnoremap <C-g> :Gtags -g
" " このファイルの関数一覧
 nnoremap <C-l> :Gtags -f %<CR>
" " カーソル以下の定義元を探す
 nnoremap <C-j> :Gtags <C-r><C-w><CR>
" " カーソル以下の使用箇所を探す
 nnoremap <C-k> :Gtags -r <C-r><C-w><CR>
" " 次の検索結果
 nnoremap <C-n> :cn<CR>
" " 前の検索結果
 nnoremap <C-p> :cp<CR>
