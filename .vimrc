syntax on
set background=dark
set showmatch
set showcmd
set ai
set tabstop=4
set textwidth=80
set expandtab
let &shiftwidth=&softtabstop
set nu
highlight Comment guifg=darkgrey ctermfg=darkgrey
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
if has("gui_running")|color wombat|endif
set guifont=Liberation\ Mono\ 8
set guioptions-=T
set t_Co=256
set mouse=a

"au BufNewFile,BufRead *.tt setf tt2html
"autocmd BufNewFile  *.pm 0r ~/.vim/skeleton.pm
"autocmd BufNewFile  *.pl 0r ~/.vim/skeleton.pl
"autocmd BufNewFile  *.t  0r ~/.vim/skeleton.t
autocmd BufEnter *.t set filetype=perl
autocmd FileType perl :noremap K :!perldoc <cword> <bar><bar> perldoc -f <cword><cr>

" set incremental searching with highlight
set incsearch
if &t_Co > 2 || has("gui_running")
        set hlsearch
endif

map <F1> :w ! perl<CR>
map <F2> <C-W>+
map <F3> <C-W>-
map <F4> <C-W>_
map <F5> <C-W>=
map <F6> :W<CR>
map <F9> <C-W>>
map <F10> <C-W><
map <F7> "*p
map <S-F7> "* P
map F zc
map f zo
xmap # :s/^/#/<CR>:nohl<CR>

"===========================================================================
" POD FOLDING - za will toggle local POD, zR expands all file, zM shrinks all file
"---------------------------------------------------------------------------
" fold POD blocks between =... and =cut
set foldexpr=getline(v:lnum)=~'^=[a-bd-z]'?1:(getline(v:lnum-1)=~'^=cut'?0:foldlevel(v:lnum-1))
set foldmethod=expr

" pretty up the fold marker for POD
set foldtext=v:folddashes.'\ '.(v:foldend-v:foldstart+1).'\ lines:\ '.substitute(getline(v:foldstart),'^=[^\ ]*\ ','','')

highlight Folded term=standout ctermfg=4 ctermbg=0

