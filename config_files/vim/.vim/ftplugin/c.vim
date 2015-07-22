iab #d #define
iab #i #include
map ,,, :call Main_generator()<CR>

function Main_generator()
    call append(line('.'), "#include<stdio.h>")
    call append(line('.') + 1, "")
    call append(line('.') + 2, "int")
    call append(line('.') + 3, "main(int argc, char * argv []) {")
    call append(line('.') + 4, "    return 0;")
    call append(line('.') + 5, "}")
endfunction
