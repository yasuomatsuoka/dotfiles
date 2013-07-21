" encoding
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,euc-jp,iso-2022-jp


" basic
set backspace=indent,eol,start
set nobackup
set autoread
set vb t_vb= 
set autoindent
set statusline=%F%M%R%=code:%B%H%W


" serach
set noignorecase " ignore case-sensitivity
set smartcase " if BOL is a capital letter, enable case-sensitivity
set hlsearch


" completion
set wildmenu " enhance command-completion


" neobundle
set nocompatible " be iMproved
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" originalrepos on github
NeoBundle 'L9'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc' "for vimshell and vim-quickrun
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'scrooloose/syntastic' " syntax check at save
NeoBundle 'FuzzyFinder'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'thinca/vim-quickrun' " \r 
NeoBundle 'surround.vim'
filetype plugin indent on
filetype indent on

" ctrlp setting
let g:ctrlp_use_migemo = 1
let g:ctrlp_clear_cache_on_exit = 0   " do not cache clear in exit
let g:ctrlp_mruf_max            = 500
let g:ctrlp_open_new_file       = 1


" neocomplcache and neosnippet
" enable in start
let g:neocomplcache_enable_at_startup = 1
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)


" keymapping
" emacs like keymap
inoremap <C-d> <Delete>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
" inoremap <C-j> <Down>
" inoremap <C-k> <Up> "diable for neosnippet
" escape hilight
noremap <ESC><ESC> :nohlsearch<CR><ESC>
" pop for ctag
nnoremap <C-[> :pop<CR>
" fuzzyfinder.vim
nnoremap <silent> ff :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <silent> fb :<C-u>:FufBuffer!<CR>


" set tab
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


" display
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


" for coffeescript
au BufNewFile,BufRead *.coffee set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.html set tabstop=2 softtabstop=2 shiftwidth=2 expandtab


" in office
if filereadable(expand('~/.vimrc.office'))
  source ~/.vimrc.office
endif
