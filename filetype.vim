au BufNewFile,BufRead *.tt call s:AdjustTT2Type() 

func! s:AdjustTT2Type() 
    if ( getline(1) . getline(2) . getline(3) =~ '<html' && getline(1) . getline(2) . getline(3) =~ '\[%' ) || getline(1) =~ '\[%.\? USE HTML' 
        setf tt2html 
    else 
        setf tt2 
    endif 
endfunc 
