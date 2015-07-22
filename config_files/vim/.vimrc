" Disable vi compatibility
set nocompatible
" Show line number
set nu
" Enable syntax
syntax on
" Auto indent
set autoindent
set cindent
" Incremental case-insensitive search 
set hlsearch
set ignorecase
set incsearch
" Color schmeme
colorscheme gentooish
" Default file encoding
set encoding=utf-8
" Specify tags file
set tags+=./tags
" Tab length
set tabstop=4
" Indent length
set softtabstop=4
set shiftwidth=4
" Use tab at the start of a line or paragraph
set smarttab
" Disable mouse
set mouse-=a
" Disable backup file
set nobackup
" Disable undo file
set noundofile
" Enable line highlight
set cursorline
" Enable column highlight
set cursorcolumn
" Fold block by syntax
set foldmethod=syntax
" 256-color support
set t_Co=256
" Set lines left to the margin
set scrolloff=3
" Completion option
set completeopt=menu,preview,longest
" Show status line always
set cmdheight=2
set laststatus=2

" Abbreviation for C main function
:ab cmain int<CR>main(int argc, char *argv[]) {}<Esc>i<CR><CR><Esc>ki<Tab><CR>return 0;<Esc>ki<Tab>

" Key map for navigating among tabs
nmap <C-l> :tabnext<CR>
nmap <C-k> :tabp<CR>

"Maps for coding with brackets
imap <C-k> <Esc>%ji
imap <C-j> <Esc>:exec "normal f" . leavechar<CR>a

func SetCursor(key1, key2) 
	" Get the current character under cursor and the one before the cursor
	let current_word = getline('.')[col('.') - 2] . getline('.')[col('.') - 1]
	if current_word == a:key1 . a:key2
		" Set the leavechar
		let g:leavechar = a:key2
		" Just like you press 'i' key in normal mode
		startinsert
	else
		" Just like you press 'a' key in normal mode
		call feedkeys('a', 'n')
	endif
endfunc
inoremap > ><Esc>:call SetCursor("<", ">")<CR>
inoremap ) )<Esc>:call SetCursor("(", ")")<CR>
inoremap } }<Esc>:call SetCursor("{", "}")<CR>
inoremap ] ]<Esc>:call SetCursor("[", "]")<CR>
inoremap " "<Esc>:call SetCursor("\"", "\"")<CR>
inoremap ' '<Esc>:call SetCursor("\'", "\'")<CR>

" Save read-only file after editing
command Sudow w !sudo tee % >/dev/null

" Refresh ctags files upon saving
autocmd BufWritePost *
      \ if filereadable('tags') |
      \   call system('exctags -R --languages='.&ft) |
      \   echo "Tag refreshed." |
      \ endif

"Read Manpage in vim
runtime! ftplugin/man.vim

" Set the runtime path to include Vundle and initialize
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins 
Plugin 'gmarik/Vundle.vim'
Plugin 'mattn/emmet-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
