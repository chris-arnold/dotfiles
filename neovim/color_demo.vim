let num = 999
while num >= 0
    exec 'hi col_'.num.' ctermbg='.num.' ctermfg=black'
    exec 'syn match col_'.num.' "ctermbg='.num.':...." containedIn=ALL'
    call append(0, 'ctermbg='.num.':....')
    let num = num - 1
endwhile
