set nocompatible
set hlsearch
set nu
syntax on
set autoindent
set ignorecase
colorscheme gentooish
set encoding=utf-8
set tags+=./tags
set ts=4
set sw=4
set expandtab
set mouse-=a
set nobackup
set noundofile
set laststatus=2
set cursorline
set cursorcolumn
set foldmethod=syntax
set nofoldenable
set t_Co=256

:ab cmain int<CR>main(int argc, char *argv[]) {}<Esc>i<CR><CR><Esc>ki<Tab><CR>return 0;<Esc>ki<Tab>
nmap <C-l> :tabnext<CR>
nmap <C-k> :tabp<CR>

"Maps for coding with brackets
imap <C-k> <Esc>%ji
imap <C-j> <Esc>:exec "normal f" . leavechar<CR>a
inoremap } }<Esc>:let leavechar="}"<CR>i
inoremap ) )<Esc>:let leavechar=")"<CR>i
inoremap ] ]<Esc>:let leavechar="]"<CR>i

"Save read-only file after editing
command Sudow w !sudo tee % >/dev/null

autocmd BufWritePost *
      \ if filereadable('tags') |
      \   call system('exctags -R --languages='.&ft) |
      \   echo "Tag refreshed." |
      \ endif

"Read Manpage in vim
runtime! ftplugin/man.vim
