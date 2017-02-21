set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'ragtag.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-fugitive'

Plugin 'tpope/vim-sensible'
Plugin 'mkropat/vim-dwiw2015'

Plugin 'vim-perl/vim-perl'

Plugin 'ctrlp.vim'

Plugin 'matchit.zip'

call vundle#end()

filetype plugin indent on

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
set viminfo='10,\"100,:20,n~/.viminfo
set guifont=Hack\ 10
set guioptions-=T
set t_Co=256
set mouse=a
set diffopt+=vertical
set rnu

set guicursor+=a:blinkon0

let g:ctrlp_working_path_mode='rw'
let g:ctrlp_root_markers='.mgconfig'

highlight Comment guifg=darkgrey ctermfg=darkgrey
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
if has("gui_running")|color wombat|endif

autocmd BufEnter *.t set filetype=perl
au BufNewFile,BufEnter *.tt setf tt2html
au BufNewFile,BufEnter *.md setf markdown
au BufNewFile,BufEnter *.pl setlocal equalprg=tidyall\ --conf-file=$HOME/.tidyallrc\ -p\ %
au BufNewFile,BufEnter *.pm setlocal equalprg=tidyall\ --conf-file=$HOME/.tidyallrc\ -p\ %
au BufNewFile,BufEnter *.css setlocal equalprg=tidyall\ --conf-file=$HOME/.tidyallrc\ -p\ %
"autocmd BufNewFile  *.pm 0r ~/.vim/skeleton.pm
"autocmd BufNewFile  *.pl 0r ~/.vim/skeleton.pl
"autocmd BufNewFile  *.t  0r ~/.vim/skeleton.t
autocmd FileType perl :noremap K :!perldoc <cword> <bar><bar> perldoc -f <cword><cr>
autocmd FileType perl :set mp=perl\ -c

" set incremental searching with highlight
set incsearch
if &t_Co > 2 || has("gui_running")
        set hlsearch
endif

map <F1> :noh<CR>
set pt=<F2>
map <F3> zo
map <F4> zc
map <F5> :make<CR>
map <F7> "*p
map <S-F7> "* P
xmap # :s/^/#/<CR>:nohl<CR>

map ]] ]}
map [[ [{

nmap <Leader>n :NERDTreeTabsToggle<CR>
nmap <Leader>d "_d
nmap <Leader>x "_x
nmap <Leader>c "_c
nmap <Leader>s "_s
nmap <Leader>r "_r
nmap <Leader>D "_D
nmap <Leader>X "_X
nmap <Leader>C "_C
nmap <Leader>S "_S
vmap <Leader>d "_d
vmap <Leader>c "_c
vmap <Leader>x "_x
vmap <Leader>s "_s
vmap <Leader>r "_r

cnoreabbrev ss syn sync fromstart
cnoreabbrev pkg put =substitute(substitute(substitute(expand('%'), '.*lib/', 'package ',''), '/', '::', 'g'), '.pm', ';', '')<CR>i 

"===========================================================================
" POD FOLDING - za will toggle local POD, zR expands all file, zM shrinks all file
"---------------------------------------------------------------------------
" fold POD blocks between =... and =cut
set foldexpr=getline(v:lnum)=~'^=[a-bd-z]'?1:(getline(v:lnum-1)=~'^=cut'?0:foldlevel(v:lnum-1))
set foldmethod=expr

" pretty up the fold marker for POD
set foldtext=v:folddashes.'\ '.(v:foldend-v:foldstart+1).'\ lines:\ '.substitute(getline(v:foldstart),'^=[^\ ]*\ ','','')

highlight Folded term=standout ctermfg=4 ctermbg=0

function! Ucfirst() range
    '<,'>s/\<./\U&/g
endfunction
com! Ucfirst call Ucfirst()

vmap <silent><Leader>u '<,'>:Ucfirst<CR>
"
" statusline:
if has('gui_running')
    set statusline=%-10.(%l(%L),%c%V%)\ \ %t%r%m%<%=%{FindSub()}
else
    set statusline=%-10.(%l(%L),%c%V%)\ \ %t%r%m%<%=%{FindSub()}\ [%{LongMode(mode())}]
endif

 
" find sub:
function! FindSub()
let subpattern = '\(sub\|function\) \w\+'
let subline = search(subpattern, 'bnW')
if !subline
return 'not in sub'
else
return matchstr(getline(subline), subpattern)
endif
endfunction 

function! LongMode(mode)
    if a:mode == 'i'
        return 'INSERT'
    elseif a:mode == 'r'
        return 'REPLACE'
    else
        return 'COMMAND'
    endif
endfunction
