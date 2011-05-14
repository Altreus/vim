" perl.vim links perlLabel to Label, but forgets to define what perlLabel
" is

" label definition
syn match perlLabel /^\I\i*:\ze\([^:]\|$\)/

" I like new and croak to look like keywords
syn keyword perlStatementNew    new
syn keyword perlStatementCarp   carp croak

hi link perlStatementNew        perlStatement
hi link perlStatementCarp       perlStatement

" Fold the given/when blocks
if exists("perl_fold_blocks")
  syn region perlBlockFold start="^\z(\s*\)\%(given\|when\)\s*(.*)\%(\s*{\)\=\s*\%(#.*\)\=$" end="^\z1}\s*;\=\%(#.*\)\=$" transparent fold keepend
endif

" rules for try/catch/... syntax defined by Error.pm
syn match perlPackageName "\(\h\w*::\)*\h\w*" contained

syn match perlStatementCatch            "\<catch\>" skipwhite nextgroup=perlPackageName
syn match perlStatementError            "\<throw\>" skipwhite nextgroup=perlPackageName

if exists("perl_fold") && exists("perl_fold_blocks")
  syn match  perlStatementTry           "\<try\>"
  syn region perlBlockTry               start="^\z(\s*\)try\s\+{" end="^\z1}" transparent fold keepend
  syn match  perlStatementWith          "\<with\>"
  syn region perlBlockCatch             start="^\z(\s*\)catch\s\+\S\+\s\+with\s\+{" end="^\z1}" transparent fold keepend
  syn match  perlStatementFinally       "\<finally\>"
  syn region perlBlockFinally           start="^\z(\s*\)finally\s\+{" end="^\z1}" transparent fold keepend
else
  syn keyword perlStatementTry          try
  syn keyword perlStatementWith         with
  syn keyword perlStatementFinally      finally
endif

highlight link perlStatementTry         perlStatementError
highlight link perlStatementCatch       perlStatementError
highlight link perlStatementWith        perlStatementError
highlight link perlStatementFinally     perlStatementError

highlight link perlStatementError       perlStatement
highlight link perlPackageName          perlType
