set nocompatible
set nu
syntax on
set autoindent
set ignorecase
colorscheme elflord
set encoding=utf-8
set tags+=./tags
set tabstop=4
set expandtab

:ab cmain int<CR>main(int argc, char *argv[]) {}<Esc>i<CR><CR><Esc>ki<Tab><CR>return 0;<Esc>ki<Tab>
nmap <C-l> :tabnext<CR>
nmap <C-k> :tabp<CR>
nmap <C-b> :tabnew 

"Save read-only file after editing
command Sudow w !sudo tee % >/dev/null

autocmd BufWritePost *
      \ if filereadable('tags') |
      \   call system('ctags -R') |
      \   echo "Tag refreshed." |
      \ endif
