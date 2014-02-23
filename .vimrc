set nocompatible
set nu
syntax on
set autoindent
set ignorecase
set autochdir
colorscheme elflord
set encoding=utf-8
:ab cmain int<CR>main(int argc, char *argv[]) {}<Esc>i<CR><CR><Esc>ki<Tab><CR>return 0;<Esc>ki<Tab>
nmap <C-l> :tabnext<CR>
nmap <C-k> :tabp<CR>
nmap <C-b> :tabnew 
